From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 13:40:51 +0100
Subject: [PATCH 1/9] USB otg: use try_module_get in all usb_get_phy
 functions and add missing module_put
In-Reply-To: <20130227123132.GM8016@arwen.pp.htv.fi>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-2-git-send-email-mkl@pengutronix.de>
 <20130227123132.GM8016@arwen.pp.htv.fi>
Message-ID: <512DFED3.7070701@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 01:31 PM, Felipe Balbi wrote:
> On Wed, Feb 27, 2013 at 01:27:07PM +0100, Marc Kleine-Budde wrote:
>> In patch "5d3c28b usb: otg: add device tree support to otg library"
>> devm_usb_get_phy_by_phandle() was added. It uses try_module_get() to lock the
>> phy driver in memory. The corresponding module_put() is missing in that patch.
>>
>> This patch adds try_module_get() to usb_get_phy() and usb_get_phy_dev().
>> Further the missing module_put() is added to usb_put_phy().
>>
>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> this one doesn't apply to my tree. What did you use as a base ?

As stated in the cover letter: Greg's usb-next.

git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git

I'd really appreciate if this series goes into a single tree. So that
other chipidea developers can base their work on this.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/18b92a36/attachment.sig>
