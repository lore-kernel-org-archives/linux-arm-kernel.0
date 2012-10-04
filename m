From: pza@pengutronix.de (Philipp Zabel)
Date: Thu, 4 Oct 2012 16:06:09 +0200
Subject: [PATCH v3 0/6] uio_pruss cleanup and platform support
In-Reply-To: <20121004135433.GI11149@beef>
References: <1349276133-26408-1-git-send-email-mporter@ti.com>
 <20121004091145.GA3317@pengutronix.de>
 <20121004124253.GC11149@beef>
 <20121004133553.GA5151@pengutronix.de>
 <20121004135433.GI11149@beef>
Message-ID: <20121004140609.GA5464@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 09:54:33AM -0400, Matt Porter wrote:
> *sigh*, I see now. I looked at v2 and got wrapped up in the DT use case
> and missed your platform device support. I think it will work just fine
> for us to use in a "phase 2" of this work, replacing the backend of
> davinci sram allocation with this as Sekhar seems to be open to. 
> 
> > > I do see it moving to your driver exclusively, but I wanted to make this
> > > series focused on only getting rid of the private SRAM API using the
> > > existing pdata framework that's already there. I think once
> > > gen_pool_find_by_phys() goes upstream we can switch to that and get the
> > > address from a resource in the !DT case. I guess we should see if Sekhar
> > > would like to see this happen in two steps or just have us depend on
> > > the gen_pool_find_by_phys() patch now.
> > 
> > Thanks, I'm glad you are aware of the sram driver and consider it useful.
> > 
> > > BTW, I was going to post a patch for your driver to allow
> > > configurability of the allocation order, but have been busy with other
> > > things.  We'll eventually need that when switching to it as the
> > > hardcoded page size order isn't going to work for all cases.
> > 
> > Good point.
> 
> I think this is the only blocker to DaVinci adopting it once it goes
> upstream. I can add a patch in your driver thread if that helps.

Yes, that would be welcome.

regards
Philipp

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
