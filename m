From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 Jan 2014 22:40:57 +0800
Subject: [PATCH v2] ARM: imx: select ARCH_HAS_CPUFREQ for iMX6SL
In-Reply-To: <1389148163-5243-1-git-send-email-john.tobias.ph@gmail.com>
References: <1389148163-5243-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <20140108144056.GD10725@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 06:29:23PM -0800, John Tobias wrote:
> iMX6SL now supports the cpufreq scaling by re-using the imx6q-cpufreq driver.
> By adding it, the user has the capability to select the said driver without
> depending it to SOC_IMX6Q.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
> Changes since v1:
> - Fix typo in commit log
> - Added Shawn Guo on Cc
> 
>  arch/arm/mach-imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 7a6e6f7..704e5ae 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -808,6 +808,7 @@ config SOC_IMX6Q
>  
>  config SOC_IMX6SL
>  	bool "i.MX6 SoloLite support"
> +	select ARCH_HAS_CPUFREQ

Since we will eventually enable CPUFREQ and OPP for most of the
platforms, maybe we should just move selection of ARCH_HAS_CPUFREQ,
ARCH_HAS_OPP and PM_OPP into 'config ARCH_MXC'?

Shawn

>  	select ARM_ERRATA_754322
>  	select ARM_ERRATA_775420
>  	select ARM_GIC
> -- 
> 1.8.3.2
> 
