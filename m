From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 17 May 2012 15:47:54 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: cosmetic: Rename exynos4 to exynos4210 in
 USB phy code
In-Reply-To: <1337163921-31052-1-git-send-email-l.majewski@samsung.com>
References: <1337163921-31052-1-git-send-email-l.majewski@samsung.com>
Message-ID: <0b1501cd33f8$fcbdb710$f6392530$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lukasz Majewski wrote:
> 
> This rename is intended to show that this code is tuned for Exynos4210
> USB controller. Name such a Exynos4 could be misleading and confuse
> Exynos4210 with Exynos4x12 SoCs.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/setup-usb-phy.c |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-
> exynos/setup-usb-phy.c
> index 6cf5d6a..403923b 100644
> --- a/arch/arm/mach-exynos/setup-usb-phy.c
> +++ b/arch/arm/mach-exynos/setup-usb-phy.c
> @@ -26,7 +26,7 @@ static int exynos4_usb_host_phy_is_on(void)
>  	return (readl(EXYNOS4_PHYPWR) & PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
>  }
> 
> -static void exynos4_usb_phy_clkset(struct platform_device *pdev)
> +static void exynos4210_usb_phy_clkset(struct platform_device *pdev)
>  {
>  	struct clk *xusbxti_clk;
>  	u32 phyclk;
> @@ -54,14 +54,14 @@ static void exynos4_usb_phy_clkset(struct
> platform_device *pdev)
>  	writel(phyclk, EXYNOS4_PHYCLK);
>  }
> 
> -static int exynos4_usb_phy0_init(struct platform_device *pdev)
> +static int exynos4210_usb_phy0_init(struct platform_device *pdev)
>  {
>  	u32 rstcon;
> 
>  	writel(readl(S5P_USBDEVICE_PHY_CONTROL) | S5P_USBDEVICE_PHY_ENABLE,
>  			S5P_USBDEVICE_PHY_CONTROL);
> 
> -	exynos4_usb_phy_clkset(pdev);
> +	exynos4210_usb_phy_clkset(pdev);
> 
>  	/* set to normal PHY0 */
>  	writel((readl(EXYNOS4_PHYPWR) & ~PHY0_NORMAL_MASK), EXYNOS4_PHYPWR);
> @@ -78,7 +78,7 @@ static int exynos4_usb_phy0_init(struct platform_device
> *pdev)
>  	return 0;
>  }
> 
> -static int exynos4_usb_phy0_exit(struct platform_device *pdev)
> +static int exynos4210_usb_phy0_exit(struct platform_device *pdev)
>  {
>  	writel((readl(EXYNOS4_PHYPWR) | PHY0_ANALOG_POWERDOWN |
>  				PHY0_OTG_DISABLE), EXYNOS4_PHYPWR);
> @@ -89,7 +89,7 @@ static int exynos4_usb_phy0_exit(struct platform_device
> *pdev)
>  	return 0;
>  }
> 
> -static int exynos4_usb_phy1_init(struct platform_device *pdev)
> +static int exynos4210_usb_phy1_init(struct platform_device *pdev)
>  {
>  	struct clk *otg_clk;
>  	u32 rstcon;
> @@ -115,7 +115,7 @@ static int exynos4_usb_phy1_init(struct
> platform_device *pdev)
>  	writel(readl(S5P_USBHOST_PHY_CONTROL) | S5P_USBHOST_PHY_ENABLE,
>  			S5P_USBHOST_PHY_CONTROL);
> 
> -	exynos4_usb_phy_clkset(pdev);
> +	exynos4210_usb_phy_clkset(pdev);
> 
>  	/* floating prevention logic: disable */
>  	writel((readl(EXYNOS4_PHY1CON) | FPENABLEN), EXYNOS4_PHY1CON);
> @@ -143,7 +143,7 @@ static int exynos4_usb_phy1_init(struct
> platform_device *pdev)
>  	return 0;
>  }
> 
> -static int exynos4_usb_phy1_exit(struct platform_device *pdev)
> +static int exynos4210_usb_phy1_exit(struct platform_device *pdev)
>  {
>  	struct clk *otg_clk;
>  	int err;
> @@ -178,9 +178,9 @@ static int exynos4_usb_phy1_exit(struct
> platform_device *pdev)
>  int s5p_usb_phy_init(struct platform_device *pdev, int type)
>  {
>  	if (type == S5P_USB_PHY_DEVICE)
> -		return exynos4_usb_phy0_init(pdev);
> +		return exynos4210_usb_phy0_init(pdev);
>  	else if (type == S5P_USB_PHY_HOST)
> -		return exynos4_usb_phy1_init(pdev);
> +		return exynos4210_usb_phy1_init(pdev);
> 
>  	return -EINVAL;
>  }
> @@ -188,9 +188,9 @@ int s5p_usb_phy_init(struct platform_device *pdev, int
> type)
>  int s5p_usb_phy_exit(struct platform_device *pdev, int type)
>  {
>  	if (type == S5P_USB_PHY_DEVICE)
> -		return exynos4_usb_phy0_exit(pdev);
> +		return exynos4210_usb_phy0_exit(pdev);
>  	else if (type == S5P_USB_PHY_HOST)
> -		return exynos4_usb_phy1_exit(pdev);
> +		return exynos4210_usb_phy1_exit(pdev);
> 
>  	return -EINVAL;
>  }
> --
> 1.7.2.3

Looks good to me and I squashed your 2 patches into original one.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
