From: balbi@ti.com (Felipe Balbi)
Date: Thu, 28 Feb 2013 13:16:37 +0200
Subject: [PATCH 2/3] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <512F21F7.5050903@pengutronix.de>
References: <1361974590-21237-1-git-send-email-mkl@pengutronix.de>
 <1361974590-21237-3-git-send-email-mkl@pengutronix.de>
 <20130228075755.GA6544@arwen.pp.htv.fi>
 <512F21F7.5050903@pengutronix.de>
Message-ID: <20130228111637.GD22736@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 10:23:03AM +0100, Marc Kleine-Budde wrote:
> On 02/28/2013 08:57 AM, Felipe Balbi wrote:
> > On Wed, Feb 27, 2013 at 03:16:29PM +0100, Marc Kleine-Budde wrote:
> >> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >>
> >> This adds two little devicetree helper functions for determining the dr_mode
> >> (host, peripheral, otg, dual-role) and phy_type (utmi, ulpi,...) from the
> >> devicetree.
> >>
> >> Cc: Felipe Balbi <balbi@ti.com>
> >> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > causes build breakage:
> > 
> > include/linux/usb/of.h:21:32: error: return type is an incomplete type
> > include/linux/usb/of.h: In function ?of_usb_get_dr_mode?:
> > include/linux/usb/of.h:23:9: error: ?USB_DR_MODE_UNKNOWN? undeclared (first use in this function)
> > include/linux/usb/of.h:23:9: note: each undeclared identifier is reported only once for each function it appears in
> > include/linux/usb/of.h:23:2: warning: ?return? with a value, in function returning void [enabled by default]
> > make[1]: *** [drivers/usb/usb-common.o] Error 1
> 
> Doh! That occurs only for non DT kernels, but who doesn't use device
> tree these days?

x86 and a bunch of ARM-SoC which haven't been converted yet

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130228/fe24097d/attachment.sig>
