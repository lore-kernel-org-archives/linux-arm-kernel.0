From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 04:45:59 +0200
Subject: [PATCH] clkdev: add support to lookup for early platform device
In-Reply-To: <20110428020910.GA13539@linux-sh.org>
References: <1303308314-3213-1-git-send-email-plagnioj@jcrosoft.com>
	<20110427084247.GK17290@n2100.arm.linux.org.uk>
	<20110427103145.GF29103@game.jcrosoft.org>
	<20110427104758.GG29103@game.jcrosoft.org>
	<20110427150057.GH29103@game.jcrosoft.org>
	<20110428020910.GA13539@linux-sh.org>
Message-ID: <20110428024559.GK29103@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:09 Thu 28 Apr     , Paul Mundt wrote:
> On Wed, Apr 27, 2011 at 05:00:57PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:47 Wed 27 Apr     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 12:31 Wed 27 Apr     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > On 09:42 Wed 27 Apr     , Russell King - ARM Linux wrote:
> > > > > On Wed, Apr 20, 2011 at 04:05:14PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > > early platform device may do not have a device name as the slab is not yet
> > > > > > available. So to search a clock base on the dev_id we need to search first the
> > > > > > device base name and then the id
> > > > > 
> > > > > I really don't like this.  IDs are platform device specific, and this is
> > > > > a platform devince independent layer.
> > > > > 
> > > > > If you want to do this, then add a platform_device_clk_get() call, which
> > > > > takes the platform device and connection id.  Uses the platform device
> > > > > infrastructure to format the device name, and use clk_get_sys() to look
> > > > > up the device/connection id from that.
> > > > I do not want to alloc a string in the clkdev
> > > > but if you prefer
> > > I check we can not do so
> > > if slab is not available we can not use kmalloc
> > > 
> > > so we can not generate the dev.init_name
> > I check also we can not use the bootmem as it's too early in the init
> > so allocate the dev_id is not possible
> > 
> > use a satic buffer I'm not so happy about it
> > the only other solution is this one
> > 
> Are you willfully ignoring the init_name handling in
> early_platform_driver_probe_id() or something?
> 
> See a636ee7fb35b731ba2b331f6294e809bb6be09c8 for example.
excatly but the issue is that the slab is not availlable yet
see 06fe53beb636294587d8e94ef83c06cef07c21fd
so init_name is still NULL :(

Best Regards,
J.
