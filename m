Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B3EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:28:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D3C20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LUuxO7yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D3C20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kMc01WXOhbmC5sn9Un/z7bjgxa9RJMthqxM6D4YLt8M=; b=LUuxO7yuGWLg6e
	a4v/20ZoQAhHxtJUqCXXc8NgOkmglt+Taig2tCAtsLybriP2U9ZKG18eu63+LY1zY6HCYO/5uF+Lu
	M37qAfsSWAydAs1y1MacpPDBEsxOOusoeeaG2IlDrd7PhWauflWf5viaV6QOnxTuUXMCHAAIyRybC
	dtUB55cQsjjRjWMAXEwtzbMIf92ejpcJk8FnoTH/WxwVbw5J1n1Kj9HmYQY47UModB9bEnDipyqwF
	AvW1we5BbqOF1Gxr8pljymKkJnSq3xGh1X3hsMkyWIsFFYgxxyBfuWkGU1Cl49j+hGyhDMO/0w5VU
	N4zbwljihrgnwpf2g2Iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUva5-0004J8-Al; Thu, 06 Dec 2018 15:28:49 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUva2-0004IN-5E
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:28:47 +0000
Received: by mail-ed1-f67.google.com with SMTP id x30so1106641edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/sm0JtBeM71zv0P6nlRXNMiUFbU+HytILsvw+2BeoS4=;
 b=sWy6Se2WQPzP0FZimg4YfcewRIa0FQEkS3M/4FGICIrN+Ms1N34t3BLxKFrFmd+lQJ
 D7avCI0UfNIkfgOjjoInxqNHWvQsNzbf61NyCFq80w7WD0KMdJ9n8LvnoN97WxJWtnIT
 2uGIRhtZ2n/TAnGLq9+Z80MDsqbqUXMkSTWO8wstbVSWilpUITgyQHzadgr26SkxPHvV
 YzwPjftBBkj5/c3xXmuzjUQCXQ2yrJdbzGXq/rPFLGVQcwMvARGEzrSur3iTBXEsKi3h
 QIt09QDmwPcfisspfffstxITdog4BGUSLZNfRgEQWrixVBcSbyl9+P21ZN1rJNLFCN2S
 ctUw==
X-Gm-Message-State: AA+aEWZiv5fBx5wRJlADr9t1o2LXz0M8RaImcJABPxyPnSxBmit/MzQV
 Sa6ZzeFVY8DfGKFpSHImqpq7ws1hUW8=
X-Google-Smtp-Source: AFSGD/WaZCjlhB/F5OMGvziiovD8qcVAj69/T48oie0BlGMne7aA1WdJTDg+2GIoKCVCCO5hkhHI5w==
X-Received: by 2002:aa7:d817:: with SMTP id v23mr25175021edq.255.1544110113221; 
 Thu, 06 Dec 2018 07:28:33 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com.
 [209.85.221.53])
 by smtp.gmail.com with ESMTPSA id o37sm247853edc.32.2018.12.06.07.28.32
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 07:28:33 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id 96so922985wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:28:32 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr25572364wrs.44.1544110112158; 
 Thu, 06 Dec 2018 07:28:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 6 Dec 2018 23:28:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v672oGHpeKEb4HV8ecZro2v-NPC9cV_DKPdNv9dy2OTREQ@mail.gmail.com>
Message-ID: <CAGb2v672oGHpeKEb4HV8ecZro2v-NPC9cV_DKPdNv9dy2OTREQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: sunxi: Account for per-bank GPIO regulators
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_072846_199994_163766B9 
X-CRM114-Status: GOOD (  18.75  )
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
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 10:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> Here is a first attempt at getting the regulators properly accounted for
> the GPIO banks on the Allwinner SoCs.

Cool. This is better than what I had in mind, which involved a deferred
task to grab the regulators.

> The main interogation I have currently is whether we should always try to
> get the regulator for the current branch, or if we should restrict it to
> the one available on the SoCs.

Not sure what you mean here, but we should probably just list the actual
names.

For pre-A20 SoCs (A10/A10s/A13), they aren't even named VCC-Px. Instead
they are named after the primary function of the pin bank, such as
VCC-CARD, VCC-NAND, VCC-CSI0, VCC-CSI1.

For pin banks that don't have per-bank power inputs, you should fall back
to VCC-IO, or VCC-RTC in the case of the PL pins.

So here's the rub: On A33 and later SoCs that are paired with a PMIC, VCC-PL
or VCC-RTC is powered by the RTC regulator of the PMIC, which only gets
registered when the PMIC regulator driver is probed, which needs the RSB
controller, which needs the pin controller and the PL pins...

ChenYu

>
> Let me know what you think,
> Maxime
>
> Maxime Ripard (2):
>   pinctrl: sunxi: Deal with per-bank regulators
>   ARM: dts: sun7i: bananapi: Add GPIO banks regulators
>
>  arch/arm/boot/dts/sun7i-a20-bananapi.dts |  5 ++-
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c    | 63 +++++++++++++++++++++++++-
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h    |  6 ++-
>  3 files changed, 74 insertions(+)
>
> base-commit: 651022382c7f8da46cb4872a545ee1da6d097d2a
> --
> git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
