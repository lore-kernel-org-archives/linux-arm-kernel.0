From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Jan 2013 12:32:29 +0200
Subject: [V2 PATCH 20/27] usb: gadget: mv_udc: add extern chip support
In-Reply-To: <1354071986-28032-21-git-send-email-chao.xie@marvell.com>
References: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
 <1354071986-28032-21-git-send-email-chao.xie@marvell.com>
Message-ID: <20130110103229.GH28920@arwen.pp.htv.fi>
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

previous mail was wrong, still needs to refresh:

patching file drivers/usb/gadget/mv_udc.h
Hunk #1 succeeded at 178 with fuzz 1.
patching file drivers/usb/gadget/mv_udc_core.c
Hunk #1 succeeded at 2091 (offset 14 lines).
Hunk #2 succeeded at 2109 (offset 14 lines).
Hunk #3 succeeded at 2138 (offset 11 lines).
Hunk #4 FAILED at 2175.
Hunk #5 FAILED at 2325.
Hunk #6 succeeded at 2390 (offset 45 lines).
Hunk #7 FAILED at 2370.
Hunk #8 FAILED at 2388.
Hunk #9 succeeded at 2453 with fuzz 1 (offset 58 lines).
4 out of 9 hunks FAILED -- saving rejects to file drivers/usb/gadget/mv_udc_core.c.rej


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/4b83e5c5/attachment.sig>
