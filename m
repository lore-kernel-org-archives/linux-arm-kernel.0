From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Jun 2012 12:38:59 +0300
Subject: [PATCH 2/2] ARM: OMAP2: Fix tusb6010 GPIO interrupt for n8x0
In-Reply-To: <20120613101512.18645.12865.stgit@muffinssi.local>
References: <20120613101303.18645.83320.stgit@muffinssi.local>
 <20120613101512.18645.12865.stgit@muffinssi.local>
Message-ID: <20120625093858.GA6468@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 03:15:12AM -0700, Tony Lindgren wrote:
> Here's one more gpio_to_irq conversion that we missed
> earlier. Tested with n800 in gadget mode using USB_ETH.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/usb-tusb6010.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
> index db84a46..805bea6 100644
> --- a/arch/arm/mach-omap2/usb-tusb6010.c
> +++ b/arch/arm/mach-omap2/usb-tusb6010.c
> @@ -300,7 +300,7 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
>  		printk(error, 3, status);
>  		return status;
>  	}
> -	tusb_resources[2].start = irq + IH_GPIO_BASE;
> +	tusb_resources[2].start = gpio_to_irq(irq);
>  
>  	/* set up memory timings ... can speed them up later */
>  	if (!ps_refclk) {
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/bd7020b7/attachment.sig>
