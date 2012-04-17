From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Apr 2012 20:01:03 +0200
Subject: [PATCH 2/8] MXS: Add USB EHCI and USB PHY clock handling
In-Reply-To: <1334657751-27678-3-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334657751-27678-3-git-send-email-marex@denx.de>
Message-ID: <20120417180103.GF3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 12:15:45PM +0200, Marek Vasut wrote:
> Based on code by:
> Tony Lin <tony.lin@freescale.com>
> 
>  	static struct clk name = {					\
>  		.enable_reg	= CLKCTRL_BASE_ADDR + HW_CLKCTRL_##er,	\
> @@ -636,8 +651,10 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("mxs-mmc.3", NULL, ssp3_clk)
>  	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
>  	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
> -	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
> -	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
> +	_REGISTER_CLOCK("mxs-ehci.0", "usb", usb0_clk)
> +	_REGISTER_CLOCK("mxs-ehci.1", "usb", usb1_clk)
> +	_REGISTER_CLOCK("mxs-phy.0", "usb0_phy", usb_phy_clk0)
> +	_REGISTER_CLOCK("mxs-phy.1", "usb1_phy", usb_phy_clk1)

The phy device name should have 'usb' in it to make clear that it's a
USB phy and not a network phy. The connection should be simply 'phy'
because the device context already makes it clear for what kind of
device the clock is.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
