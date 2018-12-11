Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849DFC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D5B20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CBX74XcA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nbp6ECBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D5B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oFV+3BsijECxYKGemx+jWlCQ/xupOl1S1j/5YK48GpM=; b=CBX74XcAp4+i8k
	5DO3+W10PFQDCfQTTp3swWREWa25K/DCtBFpqmne1IbztrpOyerAHHLW/Sjp4iFjnXnSz4WCpnONr
	LQg2YwnTMNHXjQXwqSQDkaLZAgZZL+HKb+rBgy/sXRrTIGntHpNWspmGZ6DJMraof7dRziA74r/8Z
	jOSaRypu3+w8VS/0it31RCJaInNoMwL5DMx8S9TE8ztJnpvDv0qHW48HyPznOtG7FiaxbMQ732gXU
	VJE4M1Q240YUOlqRlR1QUYIfO2LKqp6I6pURTqNt6UEhq6dNWO0IBxWuZvKYwNtcaUhM5kEtlTA82
	32/SmNxkxGfJCNp3UsOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeX2-0000Lg-9d; Tue, 11 Dec 2018 09:40:48 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeWs-00008Z-P3
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:40:45 +0000
Received: by mail-ua1-x943.google.com with SMTP id e16so4881373uam.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 01:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1FHA0e+1mmwBBktuWFq/vqc7REX2BVGHa6vEukq0Mm0=;
 b=Nbp6ECBbHJjSUni3+s7O+qCzgemHhGXKaBZMsWxkSY33nh2/O9Kn+ouEgaJ38rs/KF
 QF1lqRDQcHiWA4HmekOxBLqeLuYq1+ns/PA9nubs2NhzLveCr3OdZkxMMAdf7WrItx1f
 QN2YVg2MXa95TroEKgXbpARjM+7yLcTcsSTho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1FHA0e+1mmwBBktuWFq/vqc7REX2BVGHa6vEukq0Mm0=;
 b=WzxAaczoQm96Uptg9QWPq+pfjJL30VSGIaA4jxFXj/HQROoUsVcjHqEfjTglIgwIQZ
 DOfLt8YEsS99jiisA4nh9s+6J55M7OJBN6xtOMJ22o5Pia+XbZSOBxluKLsQHXhMbp/u
 9ge71EcgIV5Y854Wg0K58KUNLwlQ++CTQ6IM9yKyer4y9iZHudvSfQ9VIh44j8u9/u0c
 5EayvLm4WjnDtaeufcaPQPU/tSiYatjJPATcbum+fdtLSXRI5yhzxpAXX89oqUUuxW5u
 9p++3c9I+EebdCNeNt3N7Q6At2WK5DUNEve4qyWeO8O5giKGPn/r9XfS72HYle5iJZPk
 GI2Q==
X-Gm-Message-State: AA+aEWYYTVY0K+EltZWRulRA7Tex+0iRc1RDdjd+F7sSXXutqZ3d2muQ
 bUomjhSVdAaym9AmeD8sVDrOXMBxOa/KXJOYPgQUfw==
X-Google-Smtp-Source: AFSGD/XlndIoalqz9cWTgpiYhwZIKNjzTXwpn2Nmt73mZbxEoNTD6IDz+rQwapcFXenHykeWlqrREUkDuOCsyuguwU4=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr6990361uar.39.1544521227500;
 Tue, 11 Dec 2018 01:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-4-arnd@arndb.de>
In-Reply-To: <20181210215856.2238253-4-arnd@arndb.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Dec 2018 10:39:51 +0100
Message-ID: <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_014039_638555_E448C153 
X-CRM114-Status: GOOD (  16.75  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, arm@kernel.org,
 grinberg@compulab.co.il, miquel.raynal@bootlin.com,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 at 23:00, Arnd Bergmann <arnd@arndb.de> wrote:
>
> WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
> The function littleton_init_lcd() references
> the function __init pxa_set_fb_info().
> This is often because littleton_init_lcd lacks a __init
> annotation or the annotation of pxa_set_fb_info is wrong.
>
> WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
> The function zeus_register_ohci() references
> the function __init pxa_set_ohci_info().
> This is often because zeus_register_ohci lacks a __init
> annotation or the annotation of pxa_set_ohci_info is wrong.
>
> WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
> The function cm_x300_init_u2d() references
> the function __init pxa3xx_set_u2d_info().
> This is often because cm_x300_init_u2d lacks a __init
> annotation or the annotation of pxa3xx_set_u2d_info is wrong.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have queued a bunch of pxa changes via my mmc tree for gpio
descriptor conversions, by Linus Walleij.

Are those causing this problem? Should I queue this one via mmc tree as well?

Kind regards
Uffe

> ---
>  arch/arm/mach-pxa/cm-x300.c   | 2 +-
>  arch/arm/mach-pxa/littleton.c | 2 +-
>  arch/arm/mach-pxa/zeus.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index 109fab292f94..b76b566280fa 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -564,7 +564,7 @@ static struct pxa3xx_u2d_platform_data cm_x300_u2d_platform_data = {
>         .exit           = cm_x300_u2d_exit,
>  };
>
> -static void cm_x300_init_u2d(void)
> +static void __init cm_x300_init_u2d(void)
>  {
>         pxa3xx_set_u2d_info(&cm_x300_u2d_platform_data);
>  }
> diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
> index 8e0b60a33026..39db4898dc4a 100644
> --- a/arch/arm/mach-pxa/littleton.c
> +++ b/arch/arm/mach-pxa/littleton.c
> @@ -182,7 +182,7 @@ static struct pxafb_mach_info littleton_lcd_info = {
>         .lcd_conn               = LCD_COLOR_TFT_16BPP,
>  };
>
> -static void littleton_init_lcd(void)
> +static void __init littleton_init_lcd(void)
>  {
>         pxa_set_fb_info(NULL, &littleton_lcd_info);
>  }
> diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
> index 897ef59fbe0c..c411f79d4cb5 100644
> --- a/arch/arm/mach-pxa/zeus.c
> +++ b/arch/arm/mach-pxa/zeus.c
> @@ -576,7 +576,7 @@ static struct pxaohci_platform_data zeus_ohci_platform_data = {
>         .flags          = ENABLE_PORT_ALL | POWER_SENSE_LOW,
>  };
>
> -static void zeus_register_ohci(void)
> +static void __init zeus_register_ohci(void)
>  {
>         /* Port 2 is shared between host and client interface. */
>         UP2OCR = UP2OCR_HXOE | UP2OCR_HXS | UP2OCR_DMPDE | UP2OCR_DPPDE;
> --
> 2.20.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
