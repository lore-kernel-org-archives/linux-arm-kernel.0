From: gregkh@suse.de (Greg KH)
Date: Wed, 27 Apr 2011 15:12:04 -0700
Subject: [PATCH] clkdev: add support to lookup for early platform device
In-Reply-To: <20110427150057.GH29103@game.jcrosoft.org>
References: <1303308314-3213-1-git-send-email-plagnioj@jcrosoft.com>
	<20110427084247.GK17290@n2100.arm.linux.org.uk>
	<20110427103145.GF29103@game.jcrosoft.org>
	<20110427104758.GG29103@game.jcrosoft.org>
	<20110427150057.GH29103@game.jcrosoft.org>
Message-ID: <20110427221204.GC12787@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 05:00:57PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:47 Wed 27 Apr     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:31 Wed 27 Apr     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 09:42 Wed 27 Apr     , Russell King - ARM Linux wrote:
> > > > On Wed, Apr 20, 2011 at 04:05:14PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > early platform device may do not have a device name as the slab is not yet
> > > > > available. So to search a clock base on the dev_id we need to search first the
> > > > > device base name and then the id
> > > > 
> > > > I really don't like this.  IDs are platform device specific, and this is
> > > > a platform devince independent layer.
> > > > 
> > > > If you want to do this, then add a platform_device_clk_get() call, which
> > > > takes the platform device and connection id.  Uses the platform device
> > > > infrastructure to format the device name, and use clk_get_sys() to look
> > > > up the device/connection id from that.
> > > I do not want to alloc a string in the clkdev
> > > but if you prefer
> > I check we can not do so
> > if slab is not available we can not use kmalloc
> > 
> > so we can not generate the dev.init_name
> I check also we can not use the bootmem as it's too early in the init
> so allocate the dev_id is not possible
> 
> use a satic buffer I'm not so happy about it
> the only other solution is this one
> 
> which Greg or you prefer

I have no idea what you are asking, please be more specific, hopefully
including a patch showing what you are referring to.

thanks,

greg k-h
