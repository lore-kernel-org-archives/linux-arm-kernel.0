From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 11 Sep 2012 11:13:01 +0200
Subject: [PATCH v2 1/3] arm: omap: hwmod: add a new addr space in otg
 for writing to control module
In-Reply-To: <1347354580-5895-2-git-send-email-kishon@ti.com>
References: <1347354580-5895-1-git-send-email-kishon@ti.com>
 <1347354580-5895-2-git-send-email-kishon@ti.com>
Message-ID: <504F009D.3050208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 11:09 AM, Kishon Vijay Abraham I wrote:
> The mailbox register for usb otg in omap is present in control module.
> On detection of any events VBUS or ID, this register should be written
> to send the notification to musb core.
> 
> Till we have a separate control module driver to write to control module,
> omap2430 will handle the register writes to control module by itself. So
> a new address space to represent this control module register is added
> to usb_otg_hs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 242aee4..3c19120 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -5890,6 +5890,12 @@ static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
>  		.pa_end		= 0x4a0ab003,
>  		.flags		= ADDR_TYPE_RT
>  	},
> +	{
> +		/* XXX: Remove this once control module driver is in place */
> +		.pa_start	= 0x4a00233c,
> +		.pa_end		= 0x4a00233f,
> +		.flags		= ADDR_TYPE_RT
> +	},
>  	{ }
>  };
>  
> 
