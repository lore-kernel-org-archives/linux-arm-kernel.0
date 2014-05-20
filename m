From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 20 May 2014 16:08:51 +0200
Subject: [PATCH v9 10/14] ARM: config: append lpae configuration
In-Reply-To: <1400591427-21922-11-git-send-email-haojian.zhuang@linaro.org>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-11-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140520140850.GT29318@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/05/2014 at 21:10:23 +0800, Haojian Zhuang wrote :
> Append multi_v7_lpae_config. In this default configuration,
> CONFIG_ARCH_MULTI_V6 is disabled. CONFIG_ARM_LPAE is enabled.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/configs/multi_v7_lpae_defconfig | 351 +++++++++++++++++++++++++++++++
>  1 file changed, 351 insertions(+)
>  create mode 100644 arch/arm/configs/multi_v7_lpae_defconfig
> 
> diff --git a/arch/arm/configs/multi_v7_lpae_defconfig b/arch/arm/configs/multi_v7_lpae_defconfig
> new file mode 100644
> index 0000000..59fcefc
> --- /dev/null
> +++ b/arch/arm/configs/multi_v7_lpae_defconfig
> @@ -0,0 +1,351 @@
> +CONFIG_SYSVIPC=y
> +CONFIG_FHANDLE=y
> +CONFIG_IRQ_DOMAIN_DEBUG=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_EMBEDDED=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_PARTITION_ADVANCED=y
> +# CONFIG_ARCH_MULTI_V6 is not set
> +CONFIG_ARCH_MULTI_V7=y
> +CONFIG_ARM_LPAE=y
> +CONFIG_ARCH_MVEBU=y
> +CONFIG_MACH_ARMADA_370=y
> +CONFIG_MACH_ARMADA_375=y
> +CONFIG_MACH_ARMADA_38X=y
> +CONFIG_MACH_ARMADA_XP=y
> +CONFIG_MACH_DOVE=y
> +CONFIG_ARCH_BCM=y
> +CONFIG_ARCH_BCM_5301X=y
> +CONFIG_ARCH_BCM_MOBILE=y
> +CONFIG_ARCH_BERLIN=y
> +CONFIG_MACH_BERLIN_BG2=y
> +CONFIG_MACH_BERLIN_BG2CD=y

Only BG2 may be LPAE capable (and that is probably not the case). I
would suggest leaving ARCH_BERLIN out.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
