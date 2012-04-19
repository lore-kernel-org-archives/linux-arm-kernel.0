From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Apr 2012 08:34:33 +0200
Subject: [PATCH 08/10] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B76EB5@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334714869-19282-9-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B766FD@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120418084001.GN3852@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B767E8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120418094546.GO3852@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B76EB5@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <20120419063433.GF3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 02:54:18AM +0000, Chen Peter-B29397 wrote:
> 
> 
> > > >
> > > How about create a patch changing name from ehci-mxc to ehci-imx first,
> > then add
> > > mx28/mx23/mx6q host ehci driver. I can do it.
> > 
> > ehci-imx won't need clock handling and it won't need phy handling. Also
> > the setup of the portsc register won't be in the new driver. The
> > clk_get(dev, "usb_phy1") part is horribly broken anyway. It's more than
> > just a rename.
> >
> It depends on how you want things to go on, you can
> - Create ehci-mxs first, then clean up clk/phy at ehci-mxs/ehci-mxc after 
> generic phy driver and i.mx usb DT support is added, then merge ehci-mxs
> and ehci-mxc to one ehci-imx. Not sure usb maintainers agree it or not.

My idea is more to create a ehci-mxs and instead of cleaning up ehci-mxc
we switch i.MX over to the new driver and remove ehci-mxc.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
