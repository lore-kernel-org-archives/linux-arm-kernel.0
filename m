Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B89C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:59:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C0320989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QV7dCvXg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v/gwvdva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C0320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y96FgxD/1jh2E/1JSl0Zmh3mEzDEeI0GlV0Tq4Q0DWE=; b=QV7dCvXgbPWXmq
	6KDLDqqA0lyP060J1fsRUhGHttArKTIeOOAXYcpB6a40/cFcURNZHFe53n/NxwilYgXk05Wn7GU3O
	vSzsVBgvce/F4fIxEcwbkypDyI4MIAXyHUmtrr//zPO0PoJkQkJLgp14vnUfuP1VRt929Ncmgj4bC
	VKFLMka41WAkfeJtOuU6MpzWhfNfKUYSmziyYB5tXjACXe1V0yyKM9mpuSK6ni+E4pyJcgZzIolUL
	qa4woaN8AfShldr2cUMUJO+77M7ftIzojMXMIDS6DsDzlhrcHnBoc80aqb6Ut78DxlIENnjzFe7A1
	cdKTewi6IfT9DcA+BOdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goLUi-0004Gw-Km; Tue, 29 Jan 2019 04:59:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goLUZ-00049Q-4s; Tue, 29 Jan 2019 04:59:25 +0000
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8E4712183F;
 Tue, 29 Jan 2019 04:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548737961;
 bh=CeLuN0McvnCGe38oF81pKGW5d9TS5ez+UchVhZOt4m8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=v/gwvdva3OHF0eZ2nDZY6749cNZ0NzQ7k59/awuPmwhSXZiEsE7bFW7r7P9Rxnd0P
 A51Yt+W25vEOzC2Uu2xp9Lfgd4MaZqSkljowE9khj33OvSfioxDvNNmPnYQ76iJxgg
 HL5ZSJcqNklU4H5HPn3je7qUR97edUVz0ufZ/C6c=
Received: by mail-wm1-f46.google.com with SMTP id p6so16206142wmc.1;
 Mon, 28 Jan 2019 20:59:21 -0800 (PST)
X-Gm-Message-State: AJcUukeaTFQ6Sye3rEtJYtD181aVMtD2Wy3BWgqi10wH+UtxE4mWO/vt
 xUM10icGcCGyFs3WC0YfV4mQw9veDyQHGrB+6P0=
X-Google-Smtp-Source: ALg8bN5NvYxieaQOYfQ+LbULym89D+Or6inidv/e+8OvybVsvFydwB9lBvaVwXSD/sYldf6Yg6eozb+vwm21xpzvjmc=
X-Received: by 2002:a1c:6607:: with SMTP id a7mr18922742wmc.129.1548737960035; 
 Mon, 28 Jan 2019 20:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20190128223521.2690-1-voytikd@gmail.com>
In-Reply-To: <20190128223521.2690-1-voytikd@gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 28 Jan 2019 21:02:04 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoVZQx2fb-ETY=sGBB3Xx81jC8t2krczv7h=dVNE-ph2Q@mail.gmail.com>
Message-ID: <CAGp9LzoVZQx2fb-ETY=sGBB3Xx81jC8t2krczv7h=dVNE-ph2Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: fix dependencies for PINCTRL_MT76XX
To: Dmitry Voytik <voytikd@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_205923_858932_B7DED51F 
X-CRM114-Status: GOOD (  16.80  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 2:35 PM Dmitry Voytik <voytikd@gmail.com> wrote:
>
> How to reproduce the problem:
> $ make tinyconfig
> $ make menuconfig
> then enable:
>  CONFIG_COMPILE_TEST=y
>  CONFIG_PINCTRL=y
> and any of these:
>  CONFIG_PINCTRL_MT7622=y
>  CONFIG_PINCTRL_MT7629=y
>  CONFIG_PINCTRL_MT7623=y
>
> This combination causes build failure.
>
> Fix the problem by making PINCTRL_MT76XX to depend on CONFIG_OF=y.
>
> Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 1817786ab6aa..a005cbccb4f7 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -45,12 +45,14 @@ config PINCTRL_MT2701
>  config PINCTRL_MT7623
>         bool "Mediatek MT7623 pin control with generic binding"
>         depends on MACH_MT7623 || COMPILE_TEST
> +       depends on OF
>         default MACH_MT7623
>         select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT7629
>         bool "Mediatek MT7629 pin control"
>         depends on MACH_MT7629 || COMPILE_TEST
> +       depends on OF
>         default MACH_MT7629
>         select PINCTRL_MTK_MOORE
>
> @@ -92,6 +94,7 @@ config PINCTRL_MT6797
>
>  config PINCTRL_MT7622
>         bool "MediaTek MT7622 pin control"
> +       depends on OF
>         depends on ARM64 || COMPILE_TEST
>         default ARM64 && ARCH_MEDIATEK
>         select PINCTRL_MTK_MOORE
> --
> 2.20.1
>

It seems the commit 2d2d478576d71000b29c52668c5712c825ee9af8 already
fixed the problem or is there something I'm missing?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
