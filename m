From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Sep 2012 13:43:45 +0200
Subject: [RFC PATCH 1/3] amba-clcd: Add Device Tree support to amba-clcd
 driver
In-Reply-To: <1348070666-9153-2-git-send-email-ryan.harkin@linaro.org>
References: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
 <1348070666-9153-2-git-send-email-ryan.harkin@linaro.org>
Message-ID: <20120921114345.GE24458@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 05:04:24PM +0100, Ryan Harkin wrote:
> Add support to parse the display configuration from device tree.
> 
> If the board does not provide platform specific functions in the struct
> clcd_board contained with the amba device info, then defaults are provided
> by the driver.
> 
> The device tree configuration can either ask for a DMA setup or provide a
> framebuffer address to be remapped into the driver.
> 
> Signed-off-by: Ryan Harkin <ryan.harkin@linaro.org>
> ---

[...]

> +
> +struct clcd_panel *getPanel(struct device_node *node)
> +{
> +	static struct clcd_panel panel;
> +
> +	panel.mode.refresh      = get_val(node, "refresh");
> +	panel.mode.xres         = get_val(node, "xres");
> +	panel.mode.yres         = get_val(node, "yres");
> +	panel.mode.pixclock     = get_val(node, "pixclock");
> +	panel.mode.left_margin  = get_val(node, "left_margin");
> +	panel.mode.right_margin = get_val(node, "right_margin");
> +	panel.mode.upper_margin = get_val(node, "upper_margin");
> +	panel.mode.lower_margin = get_val(node, "lower_margin");
> +	panel.mode.hsync_len    = get_val(node, "hsync_len");
> +	panel.mode.vsync_len    = get_val(node, "vsync_len");
> +	panel.mode.sync         = get_val(node, "sync");

We are currently discussing a common panel description for the
devicetree. You are invited to join in here:

http://comments.gmane.org/gmane.linux.drivers.devicetree/21386

We shouldn't add any more device specific panel descriptions.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
