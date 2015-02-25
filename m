From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 25 Feb 2015 17:07:22 +0800
Subject: [PATCH 1/3] arm64: mediatek: Add config option for mt8173.
In-Reply-To: <1422342836-27689-2-git-send-email-hongzhou.yang@mediatek.com>
References: <1422342836-27689-1-git-send-email-hongzhou.yang@mediatek.com>
 <1422342836-27689-2-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1424855242.7845.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-27 at 15:13 +0800, Hongzhou Yang wrote:
> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
> 
> The upcoming MTK pinctrl driver have a big pin table for each SoC,
> and we don't want to bloat the kernel binary if we don't need it.
> Add config options so we can build for one SoC only.
> 
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  arch/arm64/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e627ead..6213dac 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -151,9 +151,15 @@ menu "Platform selection"
>  config ARCH_MEDIATEK
>  	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
>  	select ARM_GIC
> +	select PINCTRL
>  	help
>  	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
>  
> +config MACH_MT8173
> +	bool "Mediatek 8173 Soc Supprt"
> +	depends on ARCH_MEDIATEK
> +	default y
> +
>  config ARCH_SEATTLE
>  	bool "AMD Seattle SoC Family"
>  	help

Hi Arnd/Matthias,

Any comments on this patch?

Joe.C
