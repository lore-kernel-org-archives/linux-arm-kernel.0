From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 27 Apr 2011 12:31:45 +0200
Subject: [PATCH] clkdev: add support to lookup for early platform device
In-Reply-To: <20110427084247.GK17290@n2100.arm.linux.org.uk>
References: <1303308314-3213-1-git-send-email-plagnioj@jcrosoft.com>
	<20110427084247.GK17290@n2100.arm.linux.org.uk>
Message-ID: <20110427103145.GF29103@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:42 Wed 27 Apr     , Russell King - ARM Linux wrote:
> On Wed, Apr 20, 2011 at 04:05:14PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > early platform device may do not have a device name as the slab is not yet
> > available. So to search a clock base on the dev_id we need to search first the
> > device base name and then the id
> 
> I really don't like this.  IDs are platform device specific, and this is
> a platform devince independent layer.
> 
> If you want to do this, then add a platform_device_clk_get() call, which
> takes the platform device and connection id.  Uses the platform device
> infrastructure to format the device name, and use clk_get_sys() to look
> up the device/connection id from that.
I do not want to alloc a string in the clkdev
but if you prefer

Best Regards,
J.
