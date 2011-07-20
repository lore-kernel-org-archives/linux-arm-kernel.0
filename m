From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 Jul 2011 22:07:58 +0200
Subject: [PATCH 0/7] ARM: mx28: add usb host function
In-Reply-To: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
Message-ID: <20110720200757.GP26347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 07:08:19PM +0800, Tony Lin wrote:
> this patch series is to add mx28 usb host function.
> the driver only support usb host mode on usb port1.
> the driver reuses ehci-mxc.c under usb/host, but did
> some modifications based on it to satisfy mx28 usb host
> requirement. The modifications will not affect other
> platforms.
> 
> Code is based on the branch for-next in sascha's tree http://git.pengutronix.de/git/imx/linux-2.6.git


I don't really like the approach of merging a completely
unrelated architecture into the i.MX platform glue code.

Currently every architecture has it's own very similar
glue code for the EHCI driver which is bad. What is even
worse is that we have multiple (I think 4) drivers for the
gadget part of this chip. Some architectures support OTG,
others not, but all of them have a different way to attach
a USB phy to the EHCI core.

We are on the road to device tree support which should give
us a good opportunity to clean this up (We don't want to have
device tree binding code in each platform driver we have now,
right?)
Given that Freescale is currently working hard on device tree
support I think the effort is better spent in bringing the
existing oftree driver in shape for use on ARM.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
