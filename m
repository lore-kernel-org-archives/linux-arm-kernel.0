Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA99C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:24:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191B920663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sVF0cJVS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kLei3CGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191B920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GwGrTbKKFMtU3dceMZ+zlpDbWtrfZiBx8zaFJPPphfs=; b=sVF0cJVSl0yVI5
	RjfjbfhBhwZB5nv5VsHOOf3TPa2yVVCJ5JaxQr3zZIpEuflFpdNblmo4/0H9GRMrAjcuQINLVmi3J
	Out+ry++lYkdNlSR8HXQPn9IsvYPWzHKrM2MyiiHoRiOcl1KQPuuXL19nKVj+6iJe9HsFJcnD0xtE
	0hsl5UWVD1B/O8Tx0cnvfGetVQt2z5kocibonS92XtDQPLPIDaasG/8xs3MbYNhqaLl14xh/ZKSTG
	59F958z7PN8JDrdIXV0+THwrr+/zhP0fD6O9EIOYk2O66A1/zs/zp5XTZpZVeoSy8IwuU4m49/NEB
	lmF1nlqf7ra1KE3YTIRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwOY-0005ti-TS; Wed, 13 Feb 2019 15:24:18 +0000
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwOU-0005qZ-8A
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:24:16 +0000
Received: by mail-ua1-x941.google.com with SMTP id z11so884494uaa.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iepFje/MEMhk/3E4cnIjUK1NAURKmM59l2Ai+HFgl3Q=;
 b=kLei3CGVOLhHwdFp1cFntXYHYuZ7JDpvOc97rUFvIW4okfi7bSlE+J1u5TNs0A99Vq
 fJApk6VcQdqiToVxuzeZEunO5jlSdcikTUEc/aixA4IUjtSB0tb7HQMT47wHtJ+u582g
 iFeJctncDS2ZpIdUgwxsJqZ61pye1jL6q3cnBTAqFs8p4zuaWj3GiVmW+PWz6oActyCQ
 S/2dOc7XrKh7cZ78Q3V/BEtLluvmJLJouta4AkRhEpH5R+dcJwBRSWUmCqzAMewVzCFC
 OIsgFXBtW+ANZVs0p4n7n9Mwi1FhUbbbD5ySEaUTMQ8mPu6z5sMFp2/bAPI+pdOfesgx
 2I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iepFje/MEMhk/3E4cnIjUK1NAURKmM59l2Ai+HFgl3Q=;
 b=sVOvdI5C/gDlo7OAIhDple+mqImT1AkWq5w9+Bqn5wTuB7OaeioTPFq1jN3qLatH2i
 2uMoRKEbCOaR+TMfqvf8P9VnAiPvZxtkdwzM4FhDcq97hZwsnULcnikCPn7NW2QUmA19
 36gZs6+zrCbfyLJ0/vPwydQ/HELQ44Hi1OIWdGWKjTp3yOTjBBLxgsQly73zR5MSRSCj
 QmGRIOLD5jMkGH70mqQWL98WUzdTs/jRbmPoK2NJVeRrRN3o9uG6F+1RAajTSdCbsos0
 jKbci1EAPpdQfsVMpsPv+uKEmM07aiw8HUK4YIt6ZWA5l4LzCDFv1KpbOGWCobZ3Nebl
 zrTQ==
X-Gm-Message-State: AHQUAuYL/LkyFXbbp8XMlOFvwCPVbZnmk0Y54EYLWxyCqRUjmAUPChmj
 zNfZXBjTQitpDslZp7ilJ36U75GNNYBvqK7GkTmvag==
X-Google-Smtp-Source: AHgI3IaFe/NYA9tBN4Y21pnU9ZVr/OXvkJenpt1XaNeKjFdFt2/TxkkTnQrYZqdO2ACGL7o+i01j2wOp/oNYdeVv8g0=
X-Received: by 2002:ab0:2b93:: with SMTP id q19mr388945uar.130.1550071451959; 
 Wed, 13 Feb 2019 07:24:11 -0800 (PST)
MIME-Version: 1.0
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com>
 <20190211083349.GU4686@localhost> <86mun2v27r.fsf@baylibre.com>
In-Reply-To: <86mun2v27r.fsf@baylibre.com>
From: Loys Ollivier <lollivier@baylibre.com>
Date: Wed, 13 Feb 2019 16:24:00 +0100
Message-ID: <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
To: Loys Ollivier <lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_072414_287127_5D92CC9D 
X-CRM114-Status: GOOD (  17.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon 11 Feb 2019 at 14:17, Loys Ollivier <lollivier@baylibre.com> wrote:

> On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:
>
>> On Mon, Jan 28, 2019 at 04:46:53PM +0100, Loys Ollivier wrote:
>>>
>>> On Fri 25 Jan 2019 at 09:07, Johan Hovold wrote:
>>>
>>> > On Thu, Jan 17, 2019 at 05:54:32PM +0100, Loys Ollivier wrote:
>>> >> Add binding for Mediatek-based GNSS receivers.
>>> >>
>>> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>>> >> ---
>>> >>
>>> >> v2:
>>> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>>> >> Moved current-speed as an optional propertie.
>>> >> Removed the status line in the example.
>>> >> Added "mediatek,mt3339" compatible.
>>
>>> >> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
>>> >> @@ -0,0 +1,39 @@
>>> >> +Mediatek-based GNSS Receiver DT binding
>>> >> +
>>> >> +Mediatek chipsets are used in GNSS-receiver modules produced by several
>>> >> +vendors and can use UART, SPI or I2C interfaces.
>>> >> +
>>> >> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
>>> >> +properties.
>>> >> +
>>> >> +Required properties:
>>> >> +
>>> >> +- compatible    : Must be one of
>>> >> +
>>> >> +                        "globaltop,pa6h"
>>> >> +                        "mediatek,mt3339"
>>> >
>>> > I'm not sure it makes sense to add the GPS chip itself as it cannot be
>>> > used stand-alone AFAIU, and either not way would require a lot more
>>> > resources to be defined than what you add to this binding.
>>>
>>> OK, I find it a bit confusing to have Mediatek bindings but no
>>> compatible Mediatek SoCs.
>>> But it is true that it can't be used stand-alone. I will remove this
>>> reference and also remove it from the mtk.c driver code from this patch
>>> serie.
>>
>>> >> +Required properties (I2C):
>>> >> +- reg           : I2C slave address
>>> >> +
>>> >> +Required properties (SPI):
>>> >> +- reg           : SPI chip select address
>>> >
>>> > While the mt3339 appears to support these interfaces, the globaltop one
>>> > does not.
>>> >
>>> > Have you looked around for a small sample of mt3339-based receivers, to
>>> > see whether anyone actually provides these?
>>>
>>> Again I'm confused by the fact that it is the Mediatek bindings.
>>> Hence why I have added it and why it was not present in the v1 that was
>>> only for Globaltop.
>>
>> This is no different from the sirfstar driver for receivers based on
>> those chipsets but manufactured by various other vendors.
>>
> Indeed.
>
>>> I find it odd mentionning the chipset but not all its interfaces.
>>> I will remove these sections and only list supported interfaces (i.e.
>>> UART). Other interfaces can be added afterward if one finds a board that
>>> provides them.
>>
>> Right, but please do look around for other receivers using this chipset
>> so that we can make the binding generic enough to cover those as well
>> (e.g. by choosing representative resource names).
>>
> OK will have a look.

The only mt3339-based receivers I have found are:
- [0] Globaltop
- [1] Locosys / Pololu
They both only provide the UART interface and do not list the I2C/SPI
interfaces.

[0] https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6H-Datasheet-V0A.pdf
[1] https://www.pololu.com/file/0J641/LS20030~3_datasheet_v1.3.pdf

>
>> Johan



--
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
