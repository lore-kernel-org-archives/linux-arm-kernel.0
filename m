From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 16:32:55 +0000
Subject: [PATCH 07/14] usb: ehci-omap: Instantiate PHY devices if required
In-Reply-To: <50F037C9.40306@ti.com>
References: <Pine.LNX.4.44L0.1301111019340.1730-100000@iolanthe.rowland.org>
 <50F037C9.40306@ti.com>
Message-ID: <20130111163255.GF23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 06:03:21PM +0200, Roger Quadros wrote:
> diff --git a/include/linux/platform_data/usb-omap.h
> b/include/linux/platform_data/usb-omap.h
> index d63eb7d..927b8a1 100644
> --- a/include/linux/platform_data/usb-omap.h
> +++ b/include/linux/platform_data/usb-omap.h
> @@ -38,6 +38,12 @@ enum usbhs_omap_port_mode {
>  	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM
>  };
> 
> +struct usbhs_phy_config {
> +	char *name;		/* binds to device driver */

You may wish to consider making this const.
