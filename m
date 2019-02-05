Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44808C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:54:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F472080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GIXc+uK1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHqISbjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F472080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NIWa82s/0jLB2YRaaZSMftD0Yp7yJl0y3fkRRlLyOKI=; b=GIXc+uK1t+NtBa
	GrVHGL/b6iB471NtwNUM+H4OjyC+AusdXFM3/TN+IuGOp3S59/+mxSGkmWzELmBJkbOmJDY26KiAI
	TcQhcg2x8gVZMNwro2CwrNDrvqNCUI0E8J6di9JuSPo2PCD+xMLXoU005phehRc3yU8heMCoTzWtP
	q4RzC3G1OQL8OHNLD33ENTecim+VZ4A8f5K8nxhW0aynndDi1Eu2vk46j78OQanfM132g2Pz+pt63
	cLmFpm1TqFUYAz5nn4SK8RH6ZsdG5Q5ab6tR/jI4tPYqvXzsdTa4r6hHfuKEctXqG4kdnW/jJS5ws
	MZUl1Gj38bFw6RLz4xVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr6nE-0003hO-F5; Tue, 05 Feb 2019 19:54:04 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr6n7-0003cJ-Tb; Tue, 05 Feb 2019 19:54:01 +0000
Received: by mail-ot1-x341.google.com with SMTP id s13so7913611otq.4;
 Tue, 05 Feb 2019 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dAazEzP0AmczIR8hnl6k673OVHEao5Qycj49uG7Q4W4=;
 b=SHqISbjyLvYyJyF1pUWvNbVYPPWCPS+UnJ8GM3X72AAOHfuGkx9aKB0p8H49zPJLZI
 W1i7QoHLJdYNa3CJg3WQfOz2759P9mShR93p/dCRwE7WugcQuJUn7ju7JVRxVt/u1kSM
 gw7PIbPfAbjbyR4xvmlhEawJMojn3HR6COLy1IiJxZOz5tvY+2U454bPjFUeVFCKMkbG
 Fp/WYKb0u4YJfFzJkbxBXbm5bRBtX81Zg5E3dKxB0tevBPmvIkK74QZO7imXL6xrXaMu
 S7hBOZ/GJfAtLJPf1UA1YInQSPflTWkYiTLhV90E9W1nWSjMX4totIWkrQ3pwwW1O6DT
 mxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dAazEzP0AmczIR8hnl6k673OVHEao5Qycj49uG7Q4W4=;
 b=hAYOL8Rvdmefx25nS2ppbQynhgepvgHa7kk/xWz+tvIQtrDg2JmYw2JTiA9Ni90o7w
 3p4d+aS9mUzaQV29lBwgidyfP5RmrdOFOzWuXfcOieTLJBAdaBTBZBzc/pWHsyxvIFpy
 +t1KO1FT8BibCeWR41K8CTonTlmXaIl/hlRiUjq7c0W7y9heRyFqdkdSMastQu+p30Rk
 cQ1JTz0SRCEfJYJJD+aJLyxtQscjJGaoLBsjRcoPiw0BWUyZr2NUKHfIy8/4jU7+wYyY
 O1HhEZ4lt1R9zy/JX8eSsTDdbB8cKYxzQoMxRXVtDwSvS1b618Dzhi7zRaKNHXqTd6V6
 e6sA==
X-Gm-Message-State: AHQUAuZOzUpMH0F4T6IeCjCV2VC6rPEWkKd6XoLphrUxL0mxhXk7FvGr
 n3PTwFZ6H8oEAEH+5fcGVYNQbr3hvkgyCpvIdWo=
X-Google-Smtp-Source: AHgI3IbOs/NvbnBIEyAt1I3ymLP5OW3XBJtK9nMv8oS04YsfoAdHyaOoJGIVlmEq4XufBUaToL4HDR3Py6m/jKHBjUg=
X-Received: by 2002:aca:915:: with SMTP id 21mr3517231oij.163.1549396437046;
 Tue, 05 Feb 2019 11:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com>
 <20190129102521.4141-2-linux.amoon@gmail.com>
 <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com>
 <CANAwSgSnR-DWffg3vKStuXQXahLf8ONssxr4+byL=PSr5JR=xA@mail.gmail.com>
 <CAFBinCBjF5iOkUjhxSGXpQa7Nc1=bWAzA=XjrfXRYxSPZO15nQ@mail.gmail.com>
In-Reply-To: <CAFBinCBjF5iOkUjhxSGXpQa7Nc1=bWAzA=XjrfXRYxSPZO15nQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 6 Feb 2019 01:23:45 +0530
Message-ID: <CANAwSgT_q6zDVC8UVz+hrzA5Hn34eT_k-ZGB2LTO3dauT45T7g@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset
 warning
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_115358_506761_BBFEEF3E 
X-CRM114-Status: GOOD (  21.19  )
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

hi Martin,

On Tue, 5 Feb 2019 at 02:19, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, Feb 4, 2019 at 9:04 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > > @@ -36,6 +43,8 @@
> > > >                 regulator-min-microvolt = <5000000>;
> > > >                 regulator-max-microvolt = <5000000>;
> > > >
> > > > +               vin-supply = <&p5v0>;
> > > did you find out why this patch fixes the USB_OTG_PWR regulator?
> > > based on just reading the patch I can't find an explanation myself
> > >
> >
> > As per the device tree binding we need this setting to enable power input source
> > [0] Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> >
> > *I have observed few more place where this setting is missing*
> OK, I understand that we should describe the hierarchy of the regulators
>
> > > have you tested without this patch to rule out that you hit some bug
> > > in the regulator framework back when you wrote the patch?
> > > (I don't have an Odroid-C2 so I can't test this myself).
> > >
> >
> > Yes I have tested this patch.Some device like usb camera and usb hard drive
> > when connected to usb port will generate warning message.
> > which shows us that not enough power is being set to the port.
> I don't understand why adding "p5v0" as parent of "usb_otg_pwr"
> changes the output of "usb_otg_pwr":
> - "p5v0" is a fixed regulator which cannot be controlled at all (apart
> from removing power from it)
> - "usb_otg_pwr" does not have any current limits set inside the .dts
> - "usb_otg_pwr" has the same fixed voltage as the new "p5v0" regulator
>
> what are your steps-to-reproduce for your original issue ("reset
> high-speed USB device number 3 using dwc2")?
>

I have tried to reproduce this but some how I cannot get the logs
I might have enable some more debug options to reproduce but currently
it's lost.
because of over flashing of the operating system on sdcards.

But definitely this fix the power issue needed to get usb-storage
device to work on Odroid c1/c2 boards.

>
> Regards
> Martin

Best Regards

-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
