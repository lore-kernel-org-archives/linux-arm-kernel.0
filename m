From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 11:28:39 +0200
Subject: [PATCH] clkdev: add support to lookup for early platform device
In-Reply-To: <20110428083312.GL17290@n2100.arm.linux.org.uk>
References: <20110427104758.GG29103@game.jcrosoft.org>
	<20110427150057.GH29103@game.jcrosoft.org>
	<20110428020910.GA13539@linux-sh.org>
	<20110428024559.GK29103@game.jcrosoft.org>
	<20110428030817.GC13539@linux-sh.org>
	<20110428031704.GL29103@game.jcrosoft.org>
	<20110428032000.GM29103@game.jcrosoft.org>
	<BANLkTiktGTDUvLfmuH-9WgQhdc1e_S4wuQ@mail.gmail.com>
	<20110428032906.GN29103@game.jcrosoft.org>
	<20110428083312.GL17290@n2100.arm.linux.org.uk>
Message-ID: <20110428092839.GA31786@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:33 Thu 28 Apr     , Russell King - ARM Linux wrote:
> On Thu, Apr 28, 2011 at 05:29:06AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > I use it for gpio drivers that are init during map_io
> 
> Why are you initializing hardware during map_io?  That's totally crazy.
> Don't do that - the new mappings won't be flushed out of the cache/tlb
> at that point, so it's going to be hit and miss whether you can access
> the device without locking up the kernel.
> 
> Instead, use the early initialization hook which I've recently added for
> this stuff, and keep the map_io for _only_ doing what the name says.
cool which one?

Best Regards,
J.
