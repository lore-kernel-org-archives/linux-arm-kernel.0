From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Feb 2014 14:23:22 -0300
Subject: [PATCH] net: ethernet: remove unneeded dependency of mvneta and
 update help text
In-Reply-To: <20140218165128.5535a9ef@skate>
References: <1392719391-8851-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218122952.GM7862@titan.lakedaemon.net>
 <20140218134532.7607a616@skate>
 <20140218125206.GN7862@titan.lakedaemon.net>
 <20140218141303.77c77272@skate> <20140218135809.GD17984@lunn.ch>
 <20140218151027.710ab2f3@skate> <20140218154512.GA10691@localhost>
 <20140218165128.5535a9ef@skate>
Message-ID: <20140218172321.GB10691@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 04:51:28PM +0100, Thomas Petazzoni wrote:
> On Tue, 18 Feb 2014 12:45:12 -0300, Ezequiel Garcia wrote:
> 
> > > At the very end of the clean up, when even Orion5x support will be
> > > merged in mach-mvebu/, then we can certainly replace these dependencies
> > > by a "depends on ARCH_MVEBU". But for the time being, PLAT_ORION seems
> > > like the right common denominator for all these platforms.
> > > 
> > 
> > Last time we talked about this with Sebastian and Andrew it was decided
> > that the right choice is:
> > 
> >   MACH_KIRKWOOD || MACH_DOVE || MACH_ARMADA_370_XP
> 
> And why not Orion5x and MV78xx0 ?
> 

Ouch, I confused s/MARCH/ARCH. What I meant to say is that instead of
PLAT_ORION, it was agreed to use:

  ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU

See here for the previous discussion:

http://www.spinics.net/lists/devicetree/msg19091.html

We discussed the issue on its own thread:

http://www.spinics.net/lists/devicetree/msg19159.html

> > 
> > Which would become MACH_MVEBU.
> > 
> > Of course, this is near the nitpick boundary, so AFAIC you can leave
> > PLAT_ORION as in v2, if you feel like.
> 
> As I suggested previously, PLAT_ORION is what *today* controls the
> visibility of all Marvell EBU drivers. Please grep for PLAT_ORION in
> your kernel tree.

Again, it has been agreed that those are all wrong and should all
be replaced by proper ARCH_whatever. Then, we'll probably be able to
stop selecting PLAT_ORION from ARCH_MVEBU.

> So why on earth would we invent something completely
> different for mvneta?
> 

I don't have a strong opinion, it just feels wrong to have a different
rule each time. If you look at the watchdog patches, you'll notice we've
changed it to depend on ARCH_whatever.

So now you propose to go with PLAT_ORION. I'm fine with either of them;
but I think we should decide between one of them and stick to it, instead
of each of us having its own rule.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
