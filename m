From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jan 2013 14:13:36 +0200
Subject: [PATCH 1/4] drivers: usb: phy: add a new driver for usb part of
 control module
In-Reply-To: <50F93B9C.108@ti.com>
References: <1358502045-27008-1-git-send-email-kishon@ti.com>
 <1358502045-27008-2-git-send-email-kishon@ti.com>
 <20130118115909.GA4672@arwen.pp.htv.fi> <50F93B9C.108@ti.com>
Message-ID: <20130118121336.GE4672@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 18, 2013 at 05:40:04PM +0530, kishon wrote:
> >>+void omap_control_usb_host_mode(struct device *dev)
> >>+{
> >>+	u32 val;
> >>+	struct omap_control_usb	*control_usb = dev_get_drvdata(dev);
> >>+
> >>+	val = AVALID | VBUSVALID;
> >>+
> >>+	writel(val, control_usb->otghs_control);
> >
> >I would like to make this future proof too:
> >
> >val = readl(ctrl->otghs_control);
> >val |= OMAP_CTRL_DEV_AVALID | OMAP_CTRL_DEV_VBUSVALID;
> >writel(val, ctrl->otghs_control);
> 
> I think we might then have to add
> val &= ~(IDDIG | SESSEND) right?

right, my bad ;-)

> >Another idea is to try to get the extra resource below, if it fails you
> >try to continue without it ;-)
> 
> I prefer the way it is now because mailbox is needed for MUSB to be
> functional in OMAP4 and we should fail if we don't have it. No?

could be, that would mean an error on DT data though.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/4795ddc0/attachment.sig>
