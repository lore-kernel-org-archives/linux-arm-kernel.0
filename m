From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 Jun 2012 09:03:54 +0200
Subject: [PATCH] ARM: imx: cleanup otg_mode
In-Reply-To: <1417597871.2526557.1339523203564.JavaMail.root@advansee.com>
References: <1417597871.2526557.1339523203564.JavaMail.root@advansee.com>
Message-ID: <20120613070354.GV30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 07:46:43PM +0200, Beno?t Th?baudeau wrote:
> Cleanup the code for the otg_mode command line param:
> * Use the bool type as it applies here.
> * Qualify otg_mode_host with __initdata since this variable is only used in this
>   context.
> * The __setup functions are not supposed to return a status code, but a boolean
>   indicating whether the param has been handled. See obsolete_checksetup() in
>   init/main.c.
> 
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>

Applied as cleanup.

Thanks
 Sascha

> ---
>  .../arch/arm/mach-imx/mach-cpuimx27.c              |    8 ++++----
>  .../arch/arm/mach-imx/mach-cpuimx35.c              |    8 ++++----
>  .../arch/arm/mach-imx/mach-cpuimx51sd.c            |    8 ++++----
>  .../arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |    8 ++++----
>  .../arch/arm/mach-imx/mach-mx27_3ds.c              |    8 ++++----
>  .../arch/arm/mach-imx/mach-mx31_3ds.c              |    8 ++++----
>  .../arch/arm/mach-imx/mach-mx35_3ds.c              |    8 ++++----
>  .../arch/arm/mach-imx/mach-mx51_babbage.c          |    8 ++++----
>  .../arch/arm/mach-imx/mach-pca100.c                |    8 ++++----
>  .../arch/arm/mach-imx/mach-pcm037.c                |    8 ++++----
>  .../arch/arm/mach-imx/mach-pcm043.c                |    8 ++++----
>  11 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-cpuimx27.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-cpuimx27.c
> index d085aea..dbbb970 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-cpuimx27.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-cpuimx27.c
> @@ -233,18 +233,18 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
>  	.phy_mode       = FSL_USB2_PHY_ULPI,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init eukrea_cpuimx27_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", eukrea_cpuimx27_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-cpuimx35.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-cpuimx35.c
> index 6450303..7d4dc14 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-cpuimx35.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-cpuimx35.c
> @@ -141,18 +141,18 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
>  	.workaround	= FLS_USB2_WORKAROUND_ENGCM09152,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init eukrea_cpuimx35_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", eukrea_cpuimx35_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-cpuimx51sd.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-cpuimx51sd.c
> index 1e09de5..cd40bab 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-cpuimx51sd.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-cpuimx51sd.c
> @@ -217,18 +217,18 @@ static const struct mxc_usbh_platform_data usbh1_config __initconst = {
>  	.portsc	= MXC_EHCI_MODE_ULPI,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init eukrea_cpuimx51sd_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", eukrea_cpuimx51sd_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-eukrea_cpuimx25.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
> index d1e04e6..77a9edd 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
> @@ -109,18 +109,18 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
>  	.workaround     = FLS_USB2_WORKAROUND_ENGCM09152,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init eukrea_cpuimx25_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", eukrea_cpuimx25_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-mx27_3ds.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-mx27_3ds.c
> index c6d385c..cc4f83c 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-mx27_3ds.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-mx27_3ds.c
> @@ -241,18 +241,18 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
>  	.phy_mode       = FSL_USB2_PHY_ULPI,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init mx27_3ds_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", mx27_3ds_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-mx31_3ds.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-mx31_3ds.c
> index 4eafdf2..ebcadd2 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -671,18 +671,18 @@ static const struct fsl_usb2_platform_data usbotg_pdata __initconst = {
>  	.phy_mode	= FSL_USB2_PHY_ULPI,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init mx31_3ds_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", mx31_3ds_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-mx35_3ds.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-mx35_3ds.c
> index 28aa194..af92e5e 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-mx35_3ds.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-mx35_3ds.c
> @@ -540,18 +540,18 @@ static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
>  	.portsc		= MXC_EHCI_MODE_SERIAL,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init mx35_3ds_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", mx35_3ds_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-mx51_babbage.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-mx51_babbage.c
> index dde3970..3ca6902 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-mx51_babbage.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-mx51_babbage.c
> @@ -307,18 +307,18 @@ static const struct mxc_usbh_platform_data usbh1_config __initconst = {
>  	.portsc	= MXC_EHCI_MODE_ULPI,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init babbage_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", babbage_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-pca100.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-pca100.c
> index 541152e..9fe7a1b 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-pca100.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-pca100.c
> @@ -298,18 +298,18 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
>  	.phy_mode       = FSL_USB2_PHY_ULPI,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init pca100_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", pca100_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-pcm037.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-pcm037.c
> index 0a40004..debc286 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-pcm037.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-pcm037.c
> @@ -557,18 +557,18 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
>  	.phy_mode       = FSL_USB2_PHY_ULPI,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init pcm037_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", pcm037_otg_mode);
>  
> diff --git linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-pcm043.c linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-pcm043.c
> index 73585f5..a8f4a00 100644
> --- linux-next-HEAD-c90e5d2.orig/arch/arm/mach-imx/mach-pcm043.c
> +++ linux-next-HEAD-c90e5d2/arch/arm/mach-imx/mach-pcm043.c
> @@ -330,18 +330,18 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
>  	.phy_mode       = FSL_USB2_PHY_UTMI,
>  };
>  
> -static int otg_mode_host;
> +static bool otg_mode_host __initdata;
>  
>  static int __init pcm043_otg_mode(char *options)
>  {
>  	if (!strcmp(options, "host"))
> -		otg_mode_host = 1;
> +		otg_mode_host = true;
>  	else if (!strcmp(options, "device"))
> -		otg_mode_host = 0;
> +		otg_mode_host = false;
>  	else
>  		pr_info("otg_mode neither \"host\" nor \"device\". "
>  			"Defaulting to device\n");
> -	return 0;
> +	return 1;
>  }
>  __setup("otg_mode=", pcm043_otg_mode);
>  
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
