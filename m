Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54674C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:53:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202AE2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lObSWf8P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJEF/grX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202AE2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2SktS1k1q8Nwcn4UWMtk041UpBS2aBWHPwpivasnw8M=; b=lObSWf8PG4xqI5
	mNM99EKJimRBnLfBrgcVXXD/A06VasrZEXaoEmR5miL1Xe5ovvqwkl9mIMDFesnlJTWZ00mW6hsQR
	Rv+olDsJISAxyaJkBooV1SHXrYyIrXEZN3VZ9/rGD4l+h2MERBRQJqYbo/ZxFH5Xgo4xeFkuinJoy
	IdBpZiaJXbF7gmiXEybaY/FOytkCs6GOvtDuLHRJchOtSQoYhcrOpyce739YmUDkttKKJ7NRL5Q8p
	+RC1TaLcgUM8BSheN3IEmNxTIQswS/4Qmakz6Hi/35n58wi1UEr0D6j3oASXOjKYwhZdzUh1GVJLb
	CJEXTPQ75aj4RMdttydQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXAZc-0002Dw-UU; Wed, 12 Dec 2018 19:53:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXAZZ-0002D5-K2; Wed, 12 Dec 2018 19:53:35 +0000
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BAAA32084E;
 Wed, 12 Dec 2018 19:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544644403;
 bh=BYgV/+3DcIdkFyzb3CQNEnDGu6LB+hzzCchKujS2hn8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EJEF/grX90WeAxTUwKv5hE4zPaTnF3S3BgywcmFHwQJQ//iSgFM127ndJlkaAwY/S
 C4WEcTLfoPRwQFZW5snPxrbthlD4v4OAvahVdQri4HLBWav9G2tQb4/Zp1MqTMLEYV
 1+LFOMUxS34sPm754jmWi7t4elSHb7QSDz0K1KHI=
Received: by mail-wm1-f41.google.com with SMTP id a62so73046wmh.4;
 Wed, 12 Dec 2018 11:53:22 -0800 (PST)
X-Gm-Message-State: AA+aEWZ7jEJoHf/BsDgbBy1E/qm4XkIc0j3/2IpNzCkL51qUjztCWC5Y
 n7NnDYEI+8rGcxogXuUXUeBdWKTk0h4TVvQ0PGo=
X-Google-Smtp-Source: AFSGD/VrVpuI1Q7N+eDOG3tCtP0hLvUL4czloT4v6TZZCSn7tOJz/ePRa4m6pvq/9rA3L3CbJgOiZOgKEDhu3v/+irA=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr7914496wmh.92.1544644401276; 
 Wed, 12 Dec 2018 11:53:21 -0800 (PST)
MIME-Version: 1.0
References: <d80dd05f6dbfc8fe7e85509cc00ebd8ec739b4d2.1544608681.git.ryder.lee@mediatek.com>
In-Reply-To: <d80dd05f6dbfc8fe7e85509cc00ebd8ec739b4d2.1544608681.git.ryder.lee@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 12 Dec 2018 11:52:48 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzqz6ZpbZ+241HKGZxLA7EwBnw+6s2EgTy3VXaoh6Xo6Hg@mail.gmail.com>
Message-ID: <CAGp9Lzqz6ZpbZ+241HKGZxLA7EwBnw+6s2EgTy3VXaoh6Xo6Hg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: improve dependencies for
 PINCTRL_MTK_MOORE
To: =?UTF-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <ryder.lee@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_115333_690435_D1E75302 
X-CRM114-Status: GOOD (  15.78  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 weijie.gao@mediatek.com, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 1:59 AM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> Improve dependencies for the pinctrl drivers which select
> PINCTRL_MTK_MOORE as its core layer.
> ---
>  drivers/pinctrl/mediatek/Kconfig | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index d8cb584..3a41dc8 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -23,6 +23,7 @@ config PINCTRL_MTK_MOORE
>         select GENERIC_PINCTRL_GROUPS
>         select GENERIC_PINMUX_FUNCTIONS
>         select GPIOLIB
> +       select EINT_MTK

The change can be taken away from the patch as the patch EINT_MTK is
optional to the moore core.

>         select OF_GPIO
>
>  config PINCTRL_MTK_PARIS
> @@ -45,14 +46,14 @@ config PINCTRL_MT2701
>  config PINCTRL_MT7623
>         bool "Mediatek MT7623 pin control with generic binding"
>         depends on MACH_MT7623 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default MACH_MT7623
> +       select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT7629
>         bool "Mediatek MT7629 pin control"
>         depends on MACH_MT7629 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default MACH_MT7629
> +       select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT8135
>         bool "Mediatek MT8135 pin control"
> @@ -93,8 +94,8 @@ config PINCTRL_MT6797
>  config PINCTRL_MT7622
>         bool "MediaTek MT7622 pin control"
>         depends on ARM64 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default ARM64 && ARCH_MEDIATEK
> +       select PINCTRL_MTK_MOORE
>

We can add a change allowing PINCTRL_MTK_MOORE to be a non-visible
symbol in the same patch according to the general rules
kconfig-language.txt defines. And also turn PINCTRL_MTK_PARIS to
non-visible in another patch would be good.

Apart from that, the above three changes are fine with me, it helps to
be more consistent with other driver and the target SoC would be
coupled with the corresponding essential pinctrl driver.

>  config PINCTRL_MT8173
>         bool "Mediatek MT8173 pin control"
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
