From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 11:26:05 +0800
Subject: [PATCH v4 2/2] cpufreq: imx6q-cpufreq driver depends on
 SOC_IMX6Q/SOC_IMX6SL
In-Reply-To: <1389321592-33220-2-git-send-email-john.tobias.ph@gmail.com>
References: <1389321592-33220-1-git-send-email-john.tobias.ph@gmail.com>
 <1389321592-33220-2-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <20140113032603.GG23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 06:39:52PM -0800, John Tobias wrote:
> The ARCH_HAS_CPUFREQ, HAVE_IMX_ANATOP and PM_OPP are moved up to ARCH_MCX.
> The driver should show if the SOC_IMX6Q and/or SOC_IMX6SL is/are selected.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 3ba5dcc..230c663 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -80,7 +80,7 @@ config ARM_HIGHBANK_CPUFREQ
>  
>  config ARM_IMX6Q_CPUFREQ
>  	tristate "Freescale i.MX6 cpufreq support"
> -	depends on ARCH_MXC
> +	depends on SOC_IMX6Q || SOC_IMX6SL

No.  We do not want to touch this line where there is another IMX6xx can
reuse the driver.  Depending on ARCH_MXC is good enough, since we
already have the symbol prompt and help text to tell the targets that
the driver supports.

Shawn

>  	depends on REGULATOR_ANATOP
>  	help
>  	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
> -- 
> 1.8.3.2
> 
