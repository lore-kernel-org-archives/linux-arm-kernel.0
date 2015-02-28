From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 28 Feb 2015 01:16:57 +0100
Subject: [PATCH 1/2] arm64: qcom: Add support for Qualcomm MSM8916 SoC
In-Reply-To: <1425075293-14612-1-git-send-email-galak@codeaurora.org>
References: <1425075293-14612-1-git-send-email-galak@codeaurora.org>
Message-ID: <7881203.09soDMl7fe@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Freitag, 27. Februar 2015, 16:14:52 schrieb Kumar Gala:
> From: Abhimanyu Kapur <abhimany@codeaurora.org>
> 
> Add support for Qualcomm MSM8916 SoC in arm64 Kconfig and defconfig.
> Enable MSM serial driver utilized by MSM8916 and Qualcomm SoCs in
> general.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
> ---
>  arch/arm64/Kconfig           | 18 ++++++++++++++++++
>  arch/arm64/configs/defconfig |  4 ++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1b8e973..f7af379 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -177,6 +177,24 @@ config ARCH_MEDIATEK
>  	help
>  	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
> 
> +config ARCH_QCOM
> +	bool "Qualcomm Platforms"
> +	select ARCH_REQUIRE_GPIOLIB
> +	select COMMON_CLK_QCOM
> +	select PINCTRL
> +	select SOC_BUS
> +	help
> +	  This enables support for the ARMv8 based Qualcomm chipsets.
> +
> +config ARCH_QCOM_MSM8916
> +	bool "Enable Support for Qualcomm MSM8916"
> +	depends on ARCH_QCOM
> +	select MSM_GCC_8916
> +	select PINCTRL_MSM8916
> +	help
> +	  This enables support for the MSM8916 chipset. If you dont
> +	  know what do here, say N
> +

In [0] for a similar situation Arnd said

"I would rather see only one Kconfig option per SoC family and use
ARCH_MEDIATEK without any MACH_* options. We can have other options
for e.g. networking chips from Mediatek that are not closely related
but I would group all the phone and tablet chips under one option
here. Same for the other vendors of course."


[0] https://lkml.org/lkml/2015/2/25/150
