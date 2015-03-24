From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 24 Mar 2015 10:53:57 -0400
Subject: [PATCH] cpufreq: exynos: allow build for !THERMAL or
 !CPU_THERMAL cases
In-Reply-To: <2275232.48muFcOOQv@amdc1032>
References: <2275232.48muFcOOQv@amdc1032>
Message-ID: <20150324145355.GA29155@developer.hsd1.ca.comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 05:20:22PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Allow driver build for !THERMAL or !CPU_THERMAL cases.
> 
> The new dependency rule is the same as the one that CPUFREQ_DT
> option has (for cpufreq-dt driver which has the same issue with
> using of_cpufreq_cooling_register()).
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Fixes: 8b2b4a4e5366 ("cpufreq: exynos: allow modular build")
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/cpufreq/Kconfig.arm | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 1b06fc4..f4df4af3 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -28,7 +28,8 @@ config ARM_VEXPRESS_SPC_CPUFREQ
>  config ARM_EXYNOS_CPUFREQ
>  	tristate "SAMSUNG EXYNOS CPUfreq Driver"
>  	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250
> -	depends on THERMAL
> +	# if CPU_THERMAL is on and THERMAL=m, ARM_EXYNOS_CPUFREQ cannot be =y:
> +	depends on !CPU_THERMAL || THERMAL
>  	help
>  	  This adds the CPUFreq driver for Samsung EXYNOS platforms.
>  	  Supported SoC versions are:
> -- 
> 1.8.2.3
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/1de02919/attachment-0001.sig>
