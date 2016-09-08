From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 Sep 2016 17:50:36 +0000
Subject: [RFC 2/7] Make Hi3620 explicit, remove wildcards
In-Reply-To: <20160908172346.27506-2-netz.kernel@gmail.com>
References: <20160908172346.27506-1-netz.kernel@gmail.com>
 <20160908172346.27506-2-netz.kernel@gmail.com>
Message-ID: <20160908175036.GD12916@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 12:23:41PM -0500, Marty Plummer wrote:
> This is a preparatory series for adding the ARMv5/v6 hi3520 SoCs.
> Assumptions were made when adding hi3620 that don't hold water in
> light of adding support for the hi3520 SoC.  Fix the issue by renaming
> config options and other namespaces to avoid collisions with the new
> work.
> 
> Only internal APIs are modified with this series.
> 
> Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

A quick trick for figuring out the preferred Subject line format for a
subsystem is to do:

$ git log --oneline --no-merges -- arch/arm/boot/dts/

thx,

Jason.

> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index faacd52..7ffd3a3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -154,7 +154,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5440-sd5v1.dtb \
>  	exynos5440-ssdk5440.dtb \
>  	exynos5800-peach-pi.dtb
> -dtb-$(CONFIG_ARCH_HI3xxx) += \
> +dtb-$(CONFIG_ARCH_HI3620) += \
>  	hi3620-hi4511.dtb
>  dtb-$(CONFIG_ARCH_HIGHBANK) += \
>  	highbank.dtb \
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
