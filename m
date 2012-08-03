From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 Aug 2012 16:29:46 +0300
Subject: [PATCH v6 04/11] arm: omap: hwmod: add a new addr space in otg
 for writing to control module
In-Reply-To: <1343639400-28725-5-git-send-email-kishon@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-5-git-send-email-kishon@ti.com>
Message-ID: <20120803132945.GF8269@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 02:39:53PM +0530, Kishon Vijay Abraham I wrote:
> The mailbox register for usb otg in omap is present in control module.
> On detection of any events VBUS or ID, this register should be written
> to send the notification to musb core.
> 
> Till we have a separate control module driver to write to control module,
> omap2430 will handle the register writes to control module by itself. So
> a new address space to represent this control module register is added
> to usb_otg_hs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

this should come before previous patch, right ? Otherwise we will try to
ioremap a resource which isn't passed down to driver. No ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120803/3660c173/attachment.sig>
