From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 17:08:21 +0800
Subject: [PATCH] ARM: mx35_3ds: remove unnecessary USB OTG init flag
In-Reply-To: <1519251463-12318-1-git-send-email-martin@kaiser.cx>
References: <1519251463-12318-1-git-send-email-martin@kaiser.cx>
Message-ID: <20180224090818.GP3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 11:17:43PM +0100, Martin Kaiser wrote:
> The platform-specific init function for the USB OTG port,
> mx35_3ds_otg_init(), sets the MXC_EHCI_INTERNAL_PHY flag.
> 
> This flag is applicable only to the host port, not to the OTG port. It's
> ignored by mx35_initialize_usb_hw() when the OTG port is initialized.
> 
> Remove the flag to make it clear what is actually configured.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

We do not take any patch on legacy board files, unless it fixes some
real problem.

Shawn

> ---
>  arch/arm/mach-imx/mach-mx35_3ds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
> index 1c33a6c..f1963f2 100644
> --- a/arch/arm/mach-imx/mach-mx35_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx35_3ds.c
> @@ -407,7 +407,7 @@ static void __init imx35_3ds_init_mc13892(void)
>  
>  static int mx35_3ds_otg_init(struct platform_device *pdev)
>  {
> -	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERNAL_PHY);
> +	return mx35_initialize_usb_hw(pdev->id, 0);
>  }
>  
>  /* OTG config */
> -- 
> 2.1.4
> 
