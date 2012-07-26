From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jul 2012 11:57:13 +0000
Subject: [PATCH 4/8 v2] ARM: EXYNOS5: Add EHCI device from device tree
In-Reply-To: <1342866729-30460-5-git-send-email-gautam.vivek@samsung.com>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
 <1342866729-30460-5-git-send-email-gautam.vivek@samsung.com>
Message-ID: <201207261157.14441.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 July 2012, Vivek Gautam wrote:
> @@ -28,6 +29,11 @@ static struct exynos4_ohci_platdata smdk5250_ohci_pdata = {
>         .phy_exit = s5p_usb_phy_exit,
>  };
>  
> +static struct s5p_ehci_platdata smdk5250_ehci_pdata = {
> +       .phy_init = s5p_usb_phy_init,
> +       .phy_exit = s5p_usb_phy_exit,
> +};
> +
>  /*
>   * The following lookup table is used to override device names when devices
>   * are registered from device tree. This is temporarily added to enable

I'm a bit confused of the purpose of setting the function pointers here
when the pointers are always to the same s5p_usb_phy_init/s5p_usb_phy_exit
identifiers, but you have different definitions of those functions
depending on which platforms you are building for.

What is the idea here? Are you going to unify the three definitions of
s5p_usb_phy_init, or is that function going away eventually when we
get to the point of building exynos/s5p/s3c64xx into the same kernel
binary?

	Arnd
