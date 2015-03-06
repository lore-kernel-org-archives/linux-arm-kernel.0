From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Mar 2015 12:49:14 +0800
Subject: [PATCH v2] ARM: mx25: Remove mach-mx25_3ds board file
In-Reply-To: <1425385962-3109-1-git-send-email-fabio.estevam@freescale.com>
References: <1425385962-3109-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150306044912.GR20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 09:32:42AM -0300, Fabio Estevam wrote:
> imx25-pdk.dts provides a more complete support than the board file version, so
> let's get rid of the board file.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Rebased against imx/cleanup branch

I do not know what went wrong.  The v2 still doesn't apply on my branch.

$ git am -3 ~/fabio
Applying: ARM: mx25: Remove mach-mx25_3ds board file
Using index info to reconstruct a base tree...
error: removal patch leaves file contents
error: arch/arm/mach-imx/mach-mx25_3ds.c: patch does not apply
Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Cannot fall back to three-way merge.
Patch failed at 0001 ARM: mx25: Remove mach-mx25_3ds board file

Shawn

> 
>  arch/arm/mach-imx/Kconfig         |  15 ---
>  arch/arm/mach-imx/Makefile        |   1 -
>  arch/arm/mach-imx/mach-mx25_3ds.c | 270 --------------------------------------
>  3 files changed, 286 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/mach-mx25_3ds.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index f9d17f3..247a465 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -151,21 +151,6 @@ config MACH_MX21ADS
>  
>  comment "MX25 platforms:"
>  
> -config MACH_MX25_3DS
> -	bool "Support MX25PDK (3DS) Platform"
> -	select IMX_HAVE_PLATFORM_FLEXCAN
> -	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
> -	select IMX_HAVE_PLATFORM_IMX2_WDT
> -	select IMX_HAVE_PLATFORM_IMXDI_RTC
> -	select IMX_HAVE_PLATFORM_IMX_FB
> -	select IMX_HAVE_PLATFORM_IMX_I2C
> -	select IMX_HAVE_PLATFORM_IMX_KEYPAD
> -	select IMX_HAVE_PLATFORM_IMX_UART
> -	select IMX_HAVE_PLATFORM_MXC_EHCI
> -	select IMX_HAVE_PLATFORM_MXC_NAND
> -	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> -	select SOC_IMX25
> -
>  config MACH_EUKREA_CPUIMX25SD
>  	bool "Support Eukrea CPUIMX25 Platform"
>  	select IMX_HAVE_PLATFORM_FLEXCAN
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 8d1b101..e92ede9 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -49,7 +49,6 @@ obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
>  obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
>  
>  # i.MX25 based machines
> -obj-$(CONFIG_MACH_MX25_3DS) += mach-mx25_3ds.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX25SD) += mach-eukrea_cpuimx25.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD) += eukrea_mbimxsd25-baseboard.o
>  obj-$(CONFIG_MACH_IMX25_DT) += imx25-dt.o
> diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
> deleted file mode 100644
> index 584248a..0000000
> -- 
> 1.9.1
> 
