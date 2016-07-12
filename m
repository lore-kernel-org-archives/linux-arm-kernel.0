From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 12 Jul 2016 10:06:08 +0100
Subject: [PATCH] arm64: Add Broadcom Set Top Box Kconfig entry point
In-Reply-To: <1467229774-20738-1-git-send-email-mmayer@broadcom.com>
References: <1467229774-20738-1-git-send-email-mmayer@broadcom.com>
Message-ID: <5784B300.2000308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/06/16 20:49, Markus Mayer wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
>
> Add an ARCH_BRCMSTB Kconfig symbol which allows us not to update the
> dependencies for all STB-related drivers. Select BRCMSTB_L2_IRQ and
> GENERIC_IRQ_CHIP which are required for proper functioning.
>
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>
>   arch/arm64/Kconfig.platforms | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 7ef1d05..22b5c7f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -29,6 +29,13 @@ config ARCH_BERLIN
>   	help
>   	  This enables support for Marvell Berlin SoC Family
>
> +config ARCH_BRCMSTB
> +	bool "Broadcom Set-Top-Box SoCs"
> +	select BRCMSTB_L2_IRQ

I see that BRCMSTB_L2_IRQ selects GENERIC_IRQ_CHIP already so the below
one is redundant, generally irqchip code should select GENERIC_IRQ_CHIP

> +	select GENERIC_IRQ_CHIP
> +	help
> +	  This enables support for Broadcom's ARMv8 Set Top Box SoCs
> +
>   config ARCH_EXYNOS
>   	bool "ARMv8 based Samsung Exynos SoC family"
>   	select COMMON_CLK_SAMSUNG
>

-- 
Regards,
Sudeep
