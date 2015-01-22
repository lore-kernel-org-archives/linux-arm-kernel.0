From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 22 Jan 2015 13:54:12 +0100
Subject: [PATCH v5 1/5] ARM: mediatek: Add config options for mediatek
 SoCs.
In-Reply-To: <1421818097-9281-2-git-send-email-hongzhou.yang@mediatek.com>
References: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
 <1421818097-9281-2-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CABuKBeJGigY5ym9cJy=PYK8jbdsOLLtkmovHq6xho4gYseCAWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-21 6:28 GMT+01:00 Hongzhou Yang <hongzhou.yang@mediatek.com>:
> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
>
> The upcoming MTK pinctrl driver have a big pin table for each SoC
> and we don't want to bloat the kernel binary if we don't need it.
> Add config options so we can build for one SoC only.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Applied to v3.20-next/soc

> ---
>  arch/arm/mach-mediatek/Kconfig | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index f73f588..f7e463c 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -1,6 +1,26 @@
> -config ARCH_MEDIATEK
> +menuconfig ARCH_MEDIATEK
>         bool "Mediatek MT65xx & MT81xx SoC" if ARCH_MULTI_V7
>         select ARM_GIC
>         select MTK_TIMER
>         help
>           Support for Mediatek MT65xx & MT81xx SoCs
> +
> +if ARCH_MEDIATEK
> +
> +config MACH_MT6589
> +       bool "MediaTek MT6589 SoCs support"
> +       default ARCH_MEDIATEK
> +
> +config MACH_MT6592
> +       bool "MediaTek MT6592 SoCs support"
> +       default ARCH_MEDIATEK
> +
> +config MACH_MT8127
> +       bool "MediaTek MT8127 SoCs support"
> +       default ARCH_MEDIATEK
> +
> +config MACH_MT8135
> +       bool "MediaTek MT8135 SoCs support"
> +       default ARCH_MEDIATEK
> +
> +endif
> --
> 1.8.1.1.dirty
>



-- 
motzblog.wordpress.com
