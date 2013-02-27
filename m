From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 14:31:32 +0200
Subject: [PATCH 1/9] USB otg: use try_module_get in all usb_get_phy
 functions and add missing module_put
In-Reply-To: <1361968035-18644-2-git-send-email-mkl@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-2-git-send-email-mkl@pengutronix.de>
Message-ID: <20130227123132.GM8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 01:27:07PM +0100, Marc Kleine-Budde wrote:
> In patch "5d3c28b usb: otg: add device tree support to otg library"
> devm_usb_get_phy_by_phandle() was added. It uses try_module_get() to lock the
> phy driver in memory. The corresponding module_put() is missing in that patch.
> 
> This patch adds try_module_get() to usb_get_phy() and usb_get_phy_dev().
> Further the missing module_put() is added to usb_put_phy().
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

this one doesn't apply to my tree. What did you use as a base ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/3ebaefc6/attachment-0001.sig>
