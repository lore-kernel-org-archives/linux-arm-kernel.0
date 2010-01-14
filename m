From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jan 2010 11:38:15 -0800
Subject: [PATCH] ARM: Fix uncompress code compile for different
	definesof static(void)
In-Reply-To: <20100114091556.GB19197@n2100.arm.linux.org.uk>
References: <20100113021939.GE2986@atomide.com>
	<20100113084937.GA19352@pengutronix.de>
	<BD79186B4FD85F4B8E60E381CAEE190902089C39@mi8nycmail19.Mi8.com>
	<20100114082952.GA657@pengutronix.de>
	<20100114091556.GB19197@n2100.arm.linux.org.uk>
Message-ID: <20100114193815.GA7339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100114 01:14]:
> On Thu, Jan 14, 2010 at 09:29:52AM +0100, Uwe Kleine-K?nig wrote:
> > I think the cleanest solution would be to remove -Dstatic=.  I don't
> > know the exact reason for it being there.
> 
> Thereby breaking the ability to build a relocatable decompressor.
> 
> > Russell, maybe these toolchain problems are gone in the meantime?
> 
> I don't think it was toolchain problems.  Having the text and data
> segments independently relocatable is actually an abuse of the ELF
> format - it's not something it directly supports.
> 
> From what I remember, having 'static' in there results in either
> function calls or static data being indirected through the GOT table,
> which means it has to be relocated along side the data segment - which
> makes the offset between the text and data segments fixed.
> 
> I would not believe that the "problems" have gone because the toolchain
> is working how it's supposed to.
> 
> The -Dstatic= stays.

I've added the compile fix with the subject fixed into Russell's
patch system as 5882/1.

Regards,

Tony
