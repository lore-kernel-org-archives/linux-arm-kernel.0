From: w@1wt.eu (Willy Tarreau)
Date: Wed, 3 Jul 2013 06:33:30 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130702232311.GA3949@localhost>
References: <20130702124639.GI19937@titan.lakedaemon.net>
 <20130702151407.01680d21@skate> <20130702133337.GA17110@titan.lakedaemon.net>
 <20130702153825.139a93a5@skate> <20130702134421.GC17110@titan.lakedaemon.net>
 <87obakho6d.fsf@natisbad.org> <20130702174111.GF17110@titan.lakedaemon.net>
 <87y59ows4n.fsf@natisbad.org> <20130702220936.GC10215@1wt.eu>
 <20130702232311.GA3949@localhost>
Message-ID: <20130703043330.GF10215@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On Tue, Jul 02, 2013 at 08:23:12PM -0300, Ezequiel Garcia wrote:
> > Yes and indeed I must say that when I read the driver I found some
> > similarities with pxa3xx, though it was done differently. I initially
> > wanted to try to merge them but of course without the spec it's a huge
> > waste of time, especially considering that this is still in the roadmap
> > of the Free Electrons guys even though low priority.
> 
> I wish I could say I'm going to work on this soon but, as Thomas said,
> we have no idea when/if NAND will be prioritized.
> 
> On the other side if you look at the driver Willy just posted, merging
> the juicy stuff into pxa3xx-nand driver is not for the faint of heart.
> 
> Without the spec, is only tougher.

Confirmed :-)

> Just a quick hint. As far as I can recall, one of the first items in a
> TODO list should be:
> 
>  * adding bigger page support to pxa3xx (4 KiB, 8 KiB).
>    Willy's posted driver might be helpful to accomplish this;
>    provided your eyes don't melt when you look at it :-)
> 
>  * once the above is done, bad block management can/should be added.
> 
> With these two we're almost there for R/W support.

Since the driver I posted is poorly commented, I'm not even sure it
will be easy to spot the relevant parts in it.

> > Since I'm now flashing a rootfs from within u-boot, support for the
> > NAND is of less importance to me than what it used to, but I have no
> > problem with helping with my very limited time. I have 3 machines
> > with this controller (mirabox, openblocks AX3, and an XP-GP, though
> 
> With my latest patches pxa3xx-nand should at least *detect* the NAND
> device in XP-GP. Doesn't work for Mirabox, though.

OK good to know!

> > the AX3 only has NOR IIRC). I can do some tests if you manage to get
> > the driver to work again.
> > 
> > Be very careful when playing with this, the driver expects the partition
> > table to be passed from u-boot as "armada_nand", and if it uses the wrong
> > partition layout, you can be certain that ubifs will destroy them at the
> > first mount attempt. That's how I initially bricked my mirabox and did so
> > repeatedly. Better keep a copy before booting the patched kernel!
> > 
> > Another point, I had to add a new entry for the Micro 8Gb flash of the
> > mirabox, maybe you won't need it or maybe you'll need a different one.
> 
> Just a note about this. You need that entry because your driver doesn't
> support ONFI-detected flash devices. You could workaround that, by
> adding support simple command. I did it for pxa3xx-nand recently:
> 
> "mtd: nand: pxa3xx: Add address support for READID command"
> http://permalink.gmane.org/gmane.linux.drivers.mtd/46606

I remember having seen your patches, I didn't know that it allowed
to use such flashes and now it makes sense because I was surprized
about having to add entries for all possible devices while we're
not even certain that two consecutive versions of a board will use
the same brand of NAND devices.

Thanks for sharing these information, Ezequiel!

Willy
