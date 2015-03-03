From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Mar 2015 11:54:42 +0800
Subject: [PATCH] ARM: mx25: Remove mach-mx25_3ds board file
In-Reply-To: <1425138035-19715-1-git-send-email-festevam@gmail.com>
References: <1425138035-19715-1-git-send-email-festevam@gmail.com>
Message-ID: <20150303035441.GK20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 28, 2015 at 12:40:35PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx25-pdk.dts provides a more complete support than the board file version, so
> let's get rid of the board file.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

It applies neither my branch nor v4.0-rc1.  Can you please generate the
patch against imx/soc branch?

Shawn

> ---
>  arch/arm/mach-imx/Kconfig         |  15 ---
>  arch/arm/mach-imx/Makefile        |   1 -
>  arch/arm/mach-imx/mach-mx25_3ds.c | 270 --------------------------------------
>  3 files changed, 286 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/mach-mx25_3ds.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index e8627e0..aaea738 100644
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
> index 0d01e36..0000000
> -- 
> 1.9.1
> 
