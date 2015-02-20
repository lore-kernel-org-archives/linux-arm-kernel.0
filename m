From: balbi@ti.com (Felipe Balbi)
Date: Thu, 19 Feb 2015 22:38:05 -0600
Subject: [PATCH v4 4/4] phy: add phy-hi6220-usb
In-Reply-To: <54E6A4E9.4030401@linaro.org>
References: <1423726646-30336-1-git-send-email-zhangfei.gao@linaro.org>
 <1423726646-30336-5-git-send-email-zhangfei.gao@linaro.org>
 <54E4249C.9050404@ti.com> <54E426B5.4070206@linaro.org>
 <20150218143546.GD3651@saruman.tx.rr.com>
 <54E6A4E9.4030401@linaro.org>
Message-ID: <20150220043805.GA22128@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 11:07:21AM +0800, zhangfei wrote:
> Hi, Balbi
> 
> On 02/18/2015 10:35 PM, Felipe Balbi wrote:
> >On Wed, Feb 18, 2015 at 01:44:21PM +0800, zhangfei wrote:
> >>Hi, Kishon
> >>
> >>On 02/18/2015 01:35 PM, Kishon Vijay Abraham I wrote:
> >>>Hi,
> >>>
> >>>On Thursday 12 February 2015 01:07 PM, Zhangfei Gao wrote:
> >>>>Add usb phy controller for hi6220 platform
> >>>>
> >>>>Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >>>>---
> >>>>  drivers/phy/Kconfig          |   9 ++
> >>>>  drivers/phy/Makefile         |   1 +
> >>>>  drivers/phy/phy-hi6220-usb.c | 306
> >>>>+++++++++++++++++++++++++++++++++++++++++++
> >>>>  3 files changed, 316 insertions(+)
> >>>>  create mode 100644 drivers/phy/phy-hi6220-usb.c
> >>>
> >>>why is this driver in drivers/phy when it doesn't use the generic PHY
> >>>framework at all?
> >>>
> >>
> >>Balbi recommended "new drivers only on drivers/phy/", including usb
> >>phy.
> >
> >but it should use the API too. It's not only about a directory, you need
> >to use the new API.
> >
> >>So Move drivers/usb/phy/phy-hi6220-usb.c to
> >>drivers/phy/phy-hi6220-usb.c, required by Balbi.
> >
> >you're reading what I stated the way you like.
> 
> Sorry for my bad understanding.
> 
> Still not clear about the otg_set_peripheral, which is required in
> phy-hi6220-usb.c
> 
> 1. drivers/usb/dwc2/gadget.c use
> otg_set_peripheral(hsotg->uphy->otg, &hsotg->gadget);
> 
> 2. include/linux/phy/phy.h
> struct phy do not have member otg, while struct usb_phy has.
> 
> Could you give more hints?

your set_peripheral doesn't do anything, just holds a pointer. Might as
well not implement it. I'll review your driver more fully tomorrow.

There a few things which must be changed.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150219/9aa797c1/attachment.sig>
