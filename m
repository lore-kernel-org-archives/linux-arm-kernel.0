From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Nov 2015 13:27:55 +0100
Subject: [PATCH 3/3] ARM: qcom: Drop ARCH_MSM* configs
In-Reply-To: <1448413710-8101-4-git-send-email-sboyd@codeaurora.org>
References: <1448413710-8101-1-git-send-email-sboyd@codeaurora.org>
 <1448413710-8101-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <5655A94B.3030304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2015 02:08 AM, Stephen Boyd wrote:
> Drop these configs now that we select the clocksources we need
> via the defconfig.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>   arch/arm/mach-qcom/Kconfig | 16 ----------------
>   1 file changed, 16 deletions(-)
>
> diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
> index 2256cd1e25d1..37572fd79c87 100644
> --- a/arch/arm/mach-qcom/Kconfig
> +++ b/arch/arm/mach-qcom/Kconfig
> @@ -7,19 +7,3 @@ menuconfig ARCH_QCOM
>   	select QCOM_SCM if SMP
>   	help
>   	  Support for Qualcomm's devicetree based systems.
> -
> -if ARCH_QCOM
> -
> -config ARCH_MSM8X60
> -	bool "Enable support for MSM8X60"
> -	select CLKSRC_QCOM
> -
> -config ARCH_MSM8960
> -	bool "Enable support for MSM8960"
> -	select CLKSRC_QCOM
> -
> -config ARCH_MSM8974
> -	bool "Enable support for MSM8974"
> -	select HAVE_ARM_ARCH_TIMER
> -
> -endif
>

What about:

textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000

in arch/arm/Makefile

and

CONFIG_ARCH_MSM8X60=y
CONFIG_ARCH_MSM8960=y
CONFIG_ARCH_MSM8974=y

in arch/arm/configs/qcom_defconfig and multi_v7_defconfig

?

(perhaps you already did the changes and I am not looking at the right 
branch).

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
