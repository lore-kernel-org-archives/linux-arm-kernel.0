Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:06:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A5F218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fc2ywXL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A5F218FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d5trleWb0JW3ozP06Sxx0qKHyR+PxLba92l4bMxkc/k=; b=Fc2ywXL9gX3KA7
	2ED6ma2545OpSHQttT7yP/8FuEQX1XSlJV6hazMSoeQxwEqfXPQiqu0+uUmFXSBi2Bn45zdrSu7PB
	5eoRfmMFOuIH7P9Z5OWxrUhJi9uQbea1hh053H1UPxHkWcF1GB2MqpBOF9FGpjEXPTn+jhKY4P4Vx
	cQp4fnS/YieOlw5mOtmUVG99me4sAzjnBrjGHGMF/hi2aXGZUcBV3XWKLuBuHponAc2hiOh3dwO/T
	SF5J4p90jPOCY6M9nXb2AxT3ZbD1PvOa/Mqg/VWjITrjBYpCPLCJc1r4ik74SsXXJkMAEtmsdl8cR
	MVd3oJMzVmjHv7Ytaijw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhh6-0007i2-4n; Mon, 18 Feb 2019 12:06:44 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhh2-0007hf-Kw
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:06:42 +0000
Received: by mail-qk1-f193.google.com with SMTP id y140so9778547qkb.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 04:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AWJkRh6siUdGaDmneKWnVivvtFst5oz85CoGO/1XMWE=;
 b=JWeLSc31yMCAEEXobiPY/tVUnWb0kPQOMQsUuJhBbeEreqj6q85cQQXP+ehuE3gooZ
 QLb96NGu73/6cws0Q0uhWlsO1zcsCJdrFMtNtVo96UB3DiP00Ie/Gr+nGj4R9YQTNjzp
 yYu5Wos7jjiV+m8J1K8hkk1cfqmK2Rub3uJnK0xPA5o+wOINdGMZABra3hBpQhRrq8Ug
 InXhz8G6y64xHPrehARloG72Dl37Wd74H7YpM3hww5NNYIhZOg3zQqa8aloM6MXkPWI+
 TWSLEgIbtJK2IGcxnxA5yJwFxvX3AB3ZuXS8eKkmuh3xhWgkFZKtEqzFCGz0/yutYFKj
 5EAw==
X-Gm-Message-State: AHQUAuaO7RVWhVwDQZ9W/S3i9o9JtT4uNGetcIC+GkcG4TloAZBG3lR9
 1ZgeshAZpFqyParb1NhlxrXyX08u9AlCXPjT633k9nlt
X-Google-Smtp-Source: AHgI3IZ3yzAzSfG2LJnG0Gb52oIjA4zipv/djAobQ/3q1IVEMYVZ6oA+iYxfS/OPByfH6OrZrMtKO8hVXx7u4Bp8IAI=
X-Received: by 2002:a37:bdc6:: with SMTP id
 n189mr15950708qkf.330.1550491599524; 
 Mon, 18 Feb 2019 04:06:39 -0800 (PST)
MIME-Version: 1.0
References: <1549628937-363-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628937-363-1-git-send-email-sugaya.taichi@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 13:06:21 +0100
Message-ID: <CAK8P3a1+w=VWkFWBRnzBEVb389Od25pwGANtZR0DLTF0NfV-NQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] ARM: configs: Add Milbeaut M10V defconfig
To: Sugaya Taichi <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_040640_685798_4E0C02FC 
X-CRM114-Status: GOOD (  21.26  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 1:30 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This patch adds the minimal defconfig for the Milbeaut M10V.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  arch/arm/configs/milbeaut_m10v_defconfig | 366 +++++++++++++++++++++++++++++++
>  1 file changed, 366 insertions(+)


I think it would be good to reduce this a little bit. Please also add any
options you need for booting to multi_v7_defconfig. Device drivers you
don't need for booting but for additional features should be loadable
modules there.

> +CONFIG_KALLSYMS_ALL=y
> +CONFIG_EMBEDDED=y

CONFIG_EMBEDDED should not normally be set on device
configurations. Despite the name it's not something for general
embedded computing, but it's rather an option that lets you
turn other option that one should normally not have to change.

> +CONFIG_PROFILING=y
> +CONFIG_OPROFILE=m

Oprofile is rarely used these days, maybe change the default to
PERF_EVENTS=y?

> +CONFIG_HAVE_ARM_ARCH_TIMER=y
> +CONFIG_VMSPLIT_2G=y
> +CONFIG_PREEMPT=y
> +CONFIG_THUMB2_KERNEL=y

I think this will be the first armv8-a platform with thumb2 by default,
and it's probably a good thing to start testing that more.

> +CONFIG_HIGHMEM=y

It's unusual to have both VMSPLIT_2G and HIGHMEM.

> +CONFIG_ARM_APPENDED_DTB=y

If you are able to fix the boot loaders, this should be turned off

> +CONFIG_NL80211_TESTMODE=y
> +CONFIG_CFG80211_DEVELOPER_WARNINGS=y
> +CONFIG_CFG80211_REG_DEBUG=y

That seems like more debugging that you should need.

> +# CONFIG_I2C is not set
> +# CONFIG_I2C_BOARDINFO is not set
> +# CONFIG_I2C_COMPAT is not set
> +# CONFIG_I2C_CHARDEV is not set
> +# CONFIG_I2C_MUX is not set
> +# CONFIG_I2C_HELPER_AUTO is not set
> +# CONFIG_I2C_ALGOBIT is not set
> +# CONFIG_I2C_SNI_M10V is not set

If I2C is disabled, you shoulnd't need any of the later
options here.

> +CONFIG_FB=y
> +# CONFIG_VGA_ARB is not set

Since you don't have a framebuffer driver, and likely won't
add one (new drivers should use drivers/gpu/drm), I'd drop
this.

> +# CONFIG_USB is not set
> +# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
> +# CONFIG_USB_MON is not set
> +# CONFIG_USB_XHCI_HCD is not set
> +# CONFIG_USB_EHCI_HCD is not set
> +# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
...
> +# CONFIG_MMC is not set
> +# CONFIG_MMC_SDHCI is not set
> +# CONFIG_MMC_SDHCI_PLTFM is not set
> +# CONFIG_MMC_SDHCI_F_SDH30 is not set
> +# CONFIG_MMC_SDHCI_F_EMMC50 is not set

Also for USB and MMC: if you don't have the subsystem, you
should not need to list the other options.

> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_RTC_CLASS=y
> +# CONFIG_RTC_HCTOSYS is not set
> +# CONFIG_RTC_SYSTOHC is not set
> +CONFIG_RTC_DEBUG=y
> +CONFIG_RTC_DRV_RX8025=y
> +CONFIG_DMADEVICES=y
> +CONFIG_MB86S7X_HDMAC=y
> +CONFIG_MB8AC0300_XDMAC=y
> +CONFIG_UIO=y
> +CONFIG_UIO_SNI=y
> +# CONFIG_IOMMU_SUPPORT is not set
> +#CONFIG_PWM=y is not set
> +# CONFIG_PWM_SYSFS is not set
> +#CONFIG_PWM_M10V=y is not set
> +CONFIG_RESET_CONTROLLER=y
> +CONFIG_EXFAT=y

CONFIG_EXFAT does not exist in mainline kernels.

> +CONFIG_IPCU_FS=y
> +# CONFIG_TEST_IPCU_FS is not set

same for IPCU_FS, and probably a lot of other options.

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
