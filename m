From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 3 Jul 2013 10:00:55 -0300
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130703094203.37562f9c@skate>
References: <20130702151407.01680d21@skate>
 <20130702133337.GA17110@titan.lakedaemon.net>
 <20130702153825.139a93a5@skate>
 <20130702134421.GC17110@titan.lakedaemon.net>
 <87obakho6d.fsf@natisbad.org>
 <20130702174111.GF17110@titan.lakedaemon.net>
 <87y59ows4n.fsf@natisbad.org> <20130702220936.GC10215@1wt.eu>
 <20130702232311.GA3949@localhost> <20130703094203.37562f9c@skate>
Message-ID: <20130703130054.GA2382@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, Jul 03, 2013 at 09:42:03AM +0200, Thomas Petazzoni wrote:
> On Tue, 2 Jul 2013 20:23:12 -0300, Ezequiel Garcia wrote:
> 
> > I wish I could say I'm going to work on this soon but, as Thomas said,
> > we have no idea when/if NAND will be prioritized.
> > 
> > On the other side if you look at the driver Willy just posted, merging
> > the juicy stuff into pxa3xx-nand driver is not for the faint of heart.
> > 
> > Without the spec, is only tougher.
> > 
> > Just a quick hint. As far as I can recall, one of the first items in a
> > TODO list should be:
> > 
> >  * adding bigger page support to pxa3xx (4 KiB, 8 KiB).
> >    Willy's posted driver might be helpful to accomplish this;
> >    provided your eyes don't melt when you look at it :-)
> > 
> >  * once the above is done, bad block management can/should be added.
> > 
> > With these two we're almost there for R/W support.
> 
> Wasn't also part of the TODO-list to make pxa3xx_nand divorce from the
> PXA-specific DMA API, and use instead the PXA dmaengine driver, through
> the DMA engine API? As far as I remember, this was one of the
> prerequisite to be able to re-use the driver in a non-PXA context.
> There is a patch that was floating around doing this conversion (I
> could dig the relevant link if needed), but of course it needs to be
> tested, and we don't have PXA3xx hardware, so making changes to this
> driver without breaking it is quite tedious.
> 

Well that conversion is not *strictly* needed to get R/W support.
AFAICR, you just need to add some nasty ifdefs around the
mach-pxa-specific headers.

The conversion you mention is needed to have DMA on platforms
other than pxa.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
