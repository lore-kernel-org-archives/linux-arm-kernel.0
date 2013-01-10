From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Jan 2013 12:30:25 +0200
Subject: [V2 PATCH 20/27] usb: gadget: mv_udc: add extern chip support
In-Reply-To: <1354071986-28032-21-git-send-email-chao.xie@marvell.com>
References: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
 <1354071986-28032-21-git-send-email-chao.xie@marvell.com>
Message-ID: <20130110103025.GG28920@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 10:06:19PM -0500, Chao Xie wrote:
> Because arch-mmp will make use of irq domain for irq
> allocation, the irqs allocated for PMIC is dynamical.
> The vbus/idpin irqs from PMIC can not be passed by platform data.
> Using the extern chip APIs provides by PHY driver can solve this
> problem.
> Marvell usb PHY driver provides a middle layer.
> The PMIC usb drivers will help to register the callbacks in the
> marvell usb PHY driver.
> udc/otg/ehci driver will call the callbacks.
> Then we do not need pass the information in platform data. It will
> remove another block in the way of enabling device tree for usb.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

care to refresh ?

patching file drivers/usb/gadget/mv_udc.h
patching file drivers/usb/gadget/mv_udc_core.c
Hunk #2 succeeded at 1125 (offset 3 lines).
Hunk #3 succeeded at 1151 (offset 3 lines).
Hunk #4 succeeded at 2231 with fuzz 2 (offset 36 lines).
Hunk #5 FAILED at 2208.
1 out of 5 hunks FAILED -- saving rejects to file drivers/usb/gadget/mv_udc_core.c.rej

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/9441f55c/attachment.sig>
