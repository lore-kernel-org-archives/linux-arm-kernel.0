From: elder@linaro.org (Alex Elder)
Date: Fri, 04 Apr 2014 05:21:07 -0500
Subject: [PATCH 3/5] ARM: configs: enable SMP in bcm_defconfig
In-Reply-To: <1396577891-2713-4-git-send-email-elder@linaro.org>
References: <1396577891-2713-1-git-send-email-elder@linaro.org>
 <1396577891-2713-4-git-send-email-elder@linaro.org>
Message-ID: <533E8793.8060409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2014 09:18 PM, Alex Elder wrote:
> Also explicitly set CONFIG_NR_CPUS to 2, limiting it to the most we
> currently need.
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  arch/arm/configs/bcm_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 0100464..ea374a7 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -24,6 +24,8 @@ CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_PARTITION_ADVANCED=y
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=2

Since this will be part of a MULTIPLATFORM build, I don't
want to set CONFIG_NR_CPUS.  I will delete this line.

					-Alex

>  CONFIG_ARCH_BCM=y
>  CONFIG_ARCH_BCM_MOBILE=y
>  CONFIG_ARM_THUMBEE=y
> 
