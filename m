Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED779C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:26:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB4A20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CFJOsfzR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vA4cPQdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB4A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G+0FyDXqo1GoUyK1xwfYbbgSaT4LKAVc6P4+LjlJFbQ=; b=CFJOsfzRNSR601
	Pg4GTqTaBMHbQ+/GevjlSbf/8EtRpowEiwWkMiChpeTlydRiOfy/uUV7KPC2x9K1elXMfIQ8vYyX8
	j8hjUOL0OJhanVfMTsL36ClO+0AEVAoIR8IZmg9et7I73uTNZmwihs8Uh0I7Nbht3HGQcUbiUu5gN
	L3JI17j+mAyI8yNEs3krzwNRMi2jW+zFiapZr2Dx02IUoZoguy0CSl9BfrHLtOLSg7XkOnu8KCiLM
	VbbBIJv99T4gizMENshTbu30y5Ndo5WNYh68GIpBQVGdvzqod00PZsKrQ+6metZu6Py2NRdcTtDgZ
	o32WK9JFJRZfqOI79UMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdDgo-00021I-Gv; Sat, 29 Dec 2018 12:26:02 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdDgj-000205-3H; Sat, 29 Dec 2018 12:25:58 +0000
Received: by mail-oi1-x241.google.com with SMTP id c206so19170972oib.0;
 Sat, 29 Dec 2018 04:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=At8Z0beYHRSvlsti0QXxf9k/j7v0y/lOrHlNXb8ApqA=;
 b=vA4cPQdiCPDwi8tCWrgz2yrTchJYFabxsJHtPXqdKjyzhWFyNosk+4VRJLS8yaOTHp
 ghA3gyKa8gqIuhnbqdMJUIee1lB2CxijsDxnuKbTSC/LEmsiapVmD5uV3eOHRs0yuHBq
 rR6U5ljOtOHsX34LWb6ftwVDyD+zpzqOP2z6JSAEPq9ZdddUHt0IKXw43ivunWQfk78f
 u8lOdZCHcFzWzgnHO6Ee9SHx2qHkbgb8ukxmRKYYQVE+Irc0qTof4TZRYEvtp5+eSKM4
 AZjC+J5OT0cK3gOtVeec/oXISU18heuofdMQ6zH61lGXhBmhIOFU/tmKZQngA/XRJDLe
 CxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=At8Z0beYHRSvlsti0QXxf9k/j7v0y/lOrHlNXb8ApqA=;
 b=ggZ1ckN5qqjncscjA9SdZZtNmGob076pT20kKyQC24gvlw90LAzReyxbXOAFv4Ttnq
 9bC4ZfbuXl3ytL5tAqesOpiyYsjfc0tW146vi5RcGIozBfjItwvRYb7ycWiuHLfilyGC
 WdruLG+7BkqV9wj8nA5svqEhETEvMkjlM4+Cfrzjj4aGlQ5O2lFLe9Bi34SkDKJIlAii
 pjEOIBuZzAj5fSTklzPPA61pmVv+VGclGkLeBEx/RdB0bg1hygNAi/tkygBJCzF3sLmO
 lYTQ62OQff6BlfWcSB/RWpKjNf+N5TXldTnjOmFwmxse9CeqMG9XC524BFORy1yNQRTK
 dr7A==
X-Gm-Message-State: AA+aEWbSGvMI5d/PYFcj28lcSKK4Erqr8Q0uMbRQJjwqe5tn8MkIOtY0
 URGX0O0xEFEfeJZ4Js98gSmmuhDpBmDWSRMHKCxmnA==
X-Google-Smtp-Source: AFSGD/UM07oeCxok/vDA5zAaLLhhI1w7whF31E7mxEiwZ0gyP5okanSECLlXcf/+1HhJ9I+pfa8zBL1iNplB7YMOAIs=
X-Received: by 2002:aca:4b48:: with SMTP id y69mr20722247oia.200.1546086343742; 
 Sat, 29 Dec 2018 04:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20181229000829.16571-1-martin.blumenstingl@googlemail.com>
 <491fb35b-3e2a-89ab-94c6-c9e8d89a1b01@amlogic.com>
In-Reply-To: <491fb35b-3e2a-89ab-94c6-c9e8d89a1b01@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 29 Dec 2018 13:25:32 +0100
Message-ID: <CAFBinCCQgpyoNGRh0WBziL0piyB6fas1cg6JSTNcZ3G6Jxo1OA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Meson8b RGMII Ethernet pin cleanup
To: Jianxin Pan <jianxin.pan@amlogic.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_042557_169724_B6726498 
X-CRM114-Status: GOOD (  14.32  )
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
Cc: linus.luessing@c0d3.blue, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, ingrassia@epigenesys.com,
 khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jianxin,

that was very quick!

On Sat, Dec 29, 2018 at 6:17 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>
> Hi Martin,
>
>
> PERIPHS_PIN_MUX_7:
> - register 7 bit 22: ETH_RXD3 (DIF_TTL_2_P)
> - register 7 bit 23: ETH_RXD2 (DIF_TTL_2_N)
perfect, thank you - that is exactly the information I need to add the
missing bits to the pinctrl-meson8b driver
finally Odroid-C1 won't drop packets when transferring data anymore
and we rely less on the bootloader to set up the pin mux :)

> On 2018/12/29 8:08, Martin Blumenstingl wrote:
> > Hi Emiliano, Hi Linus, Hi Jianxin,
> >
> > could you please test the patch from this series on your Odroid-C1?
> > I tested it on mine and Ethernet seems to be improve Ethernet transmit
> > speeds greatly (at the cost of a small drop in receive performance).
> >
> > Jianxin, can you please give us the description for pin mux register 7
> > (PERIPHS_PIN_MUX_7) bits 22 and 23 on Meson8b (S805). The public
> > datasheet doesn't mention them so we're missing the name of the function
> > and the pin(s) which are controlled by each bit.
I will send an updated series (which will include a pinctrl-meson8b
patch and an updated .dts patch) later on


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
