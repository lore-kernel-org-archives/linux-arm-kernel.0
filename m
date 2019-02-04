Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:49:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7082073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R5jwLm5k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HrSLwR9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7082073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ocWQiU2bKqY5GomvCil6tJx9nFSzAEu/oZalllmuCXs=; b=R5jwLm5kkm2MMa
	Tkj3bs535n0AlLqzA81aAE1A74UEOJVD2aU5SbIolDIPA+RcGKC7YRN1+FQyqDtGNAsgg8P/zTZuB
	dBBc7kM0SuDbi+2iUMeyhrWxaaOtECFVTBTcrkjw4J58QRDHWi8b+0cwdi/YOylLnWmdwEvHYpp8o
	UV7cauaYBCijgPmS5GDrqjaDEuTzxYltH7DNApKPJ2Y21Em+csEr0yydd6YznNi0WsGqBJ09GTiMV
	nQytDTXgyEgZIPQ/nOG1APBUliDXg1FpL5ebJTgQf2ZD+jGgrRQ9yx8iqy1wJ3jdNx0pp7OBLcaF2
	AIqESYR+ILcdDWOJ0sTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqlBW-000698-6J; Mon, 04 Feb 2019 20:49:42 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqlBS-00068a-Fh; Mon, 04 Feb 2019 20:49:39 +0000
Received: by mail-ot1-x343.google.com with SMTP id s5so2170072oth.7;
 Mon, 04 Feb 2019 12:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tord4prjwOyjm36JPqP6avPb7bbeEZzoWDKJvQIGCQA=;
 b=HrSLwR9XJJbiuRMaCDrGJGSfib9zpAelRfvut2zDcp88SBz1UVj+1YvPB2QTRi9D/t
 TLJmUGnMQTbo7ABMj0HCBfCBeodzc1BccKkDTCMu1o/GFgqgYXYpjcOpMihXowY97vX5
 Sek73EP9mnoOcb5DgSVc5Vx9UrZFsVCQSiEHS5h3wtqg7xVcqBeIPO3KLkD3vPuFl8oS
 qKWu+FetIxaY380DRdIBSBMgr2tI8rzS3EMoUBh1rO7//A2w1epZUg2YeHxkyXPw2aE7
 5WXUZAM14DdquEdOtYTcEv/s8aA5u0WlcisDp+M9OyByPOpyHjSBtHP/Kl3gLPGtQy9j
 1zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tord4prjwOyjm36JPqP6avPb7bbeEZzoWDKJvQIGCQA=;
 b=IwzCrFTfpVfRAAUPzEZSofQjokMk13C/GochhBhXyd4SxWD7pW3mKZYzvsuGTAim2u
 rVSm85WQ6JxTOjRz6OPYQ5zp5beKgWayHOZ9ErcqSiniXIkhmvt4xW8sLCvYNf5nH/ce
 S5iUQitLDkAXR+jJsHcYtYXLVMk+ynROcDPMNOHxGsBAcUjddDPC2s27XTT571rA8JOT
 Qf0lJNL7S8uiU76QRScpvHv+em01SfNZH8K9zLkFMJ3PIvCewmoyt4tXdnayUPZe9PNS
 TIYBoQiqngyJ2aHNZMezniPKt3jLHgpCcs8R0d6kcokMEnZ+kr/QBTdmnwQbxQow7FNB
 sMkw==
X-Gm-Message-State: AHQUAub3xV1oc+VuJATEGzu8WkKB3BQaFkJCbN2Q84l6E5Ze/XUK1Jux
 8hD48lLQiiQ5F44gNvHM1I2Ofdf23aDdkwf5wyA=
X-Google-Smtp-Source: AHgI3IZtxfCzW6NJ3v6eHXfXL6pGpISmEjJTIQBnGGW0QKPOSKtMRALRQdYHlwd4w9vR55gOzLGxHuWUQFWKRYN6GW0=
X-Received: by 2002:aca:3586:: with SMTP id c128mr712196oia.47.1549313377317; 
 Mon, 04 Feb 2019 12:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com>
 <20190129102521.4141-2-linux.amoon@gmail.com>
 <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com>
 <CANAwSgSnR-DWffg3vKStuXQXahLf8ONssxr4+byL=PSr5JR=xA@mail.gmail.com>
In-Reply-To: <CANAwSgSnR-DWffg3vKStuXQXahLf8ONssxr4+byL=PSr5JR=xA@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Feb 2019 21:49:26 +0100
Message-ID: <CAFBinCBjF5iOkUjhxSGXpQa7Nc1=bWAzA=XjrfXRYxSPZO15nQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset
 warning
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_124938_590744_C95B727E 
X-CRM114-Status: GOOD (  16.27  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree <devicetree@vger.kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Mon, Feb 4, 2019 at 9:04 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > > @@ -36,6 +43,8 @@
> > >                 regulator-min-microvolt = <5000000>;
> > >                 regulator-max-microvolt = <5000000>;
> > >
> > > +               vin-supply = <&p5v0>;
> > did you find out why this patch fixes the USB_OTG_PWR regulator?
> > based on just reading the patch I can't find an explanation myself
> >
>
> As per the device tree binding we need this setting to enable power input source
> [0] Documentation/devicetree/bindings/regulator/fixed-regulator.txt
>
> *I have observed few more place where this setting is missing*
OK, I understand that we should describe the hierarchy of the regulators

> > have you tested without this patch to rule out that you hit some bug
> > in the regulator framework back when you wrote the patch?
> > (I don't have an Odroid-C2 so I can't test this myself).
> >
>
> Yes I have tested this patch.Some device like usb camera and usb hard drive
> when connected to usb port will generate warning message.
> which shows us that not enough power is being set to the port.
I don't understand why adding "p5v0" as parent of "usb_otg_pwr"
changes the output of "usb_otg_pwr":
- "p5v0" is a fixed regulator which cannot be controlled at all (apart
from removing power from it)
- "usb_otg_pwr" does not have any current limits set inside the .dts
- "usb_otg_pwr" has the same fixed voltage as the new "p5v0" regulator

what are your steps-to-reproduce for your original issue ("reset
high-speed USB device number 3 using dwc2")?


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
