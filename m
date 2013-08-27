From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 Aug 2013 18:51:29 +0200
Subject: [RFC v1 0/5] ARM: Initial support for Marvell Armada 1500
In-Reply-To: <521CD7B9.7060208@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130827161958.5e71890d@skate> <521CD7B9.7060208@gmail.com>
Message-ID: <20130827185129.31bd0c9e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Tue, 27 Aug 2013 18:45:45 +0200, Sebastian Hesselbarth wrote:

> > After talking a bit with engineers within Marvell that work on this
> > SoC, I'm inclined to think that using mach-mvebu for this family of SoC
> > is not a good idea.
> 
> Thomas,
> 
> thanks for the info below. Reading a little bit through the GPL'ed
> source, I also quickly came to the same conclusion. It is more likely
> we can reuse some stuff from other SoCs than Orion or Armada 370/XP.

Yes, many of the IP blocks are for example DesignWare IPs, or ARM IPs
in the case of the Cortex-A based variants.

> > The codename used for those Armada 1500 SOCs is "Berlin", so a name
> > like mach-berlin, or mach-mvberlin (if we want to keep 'mv' to identify
> > the founder) seems like a good name.
> 
> I have already moved it under mach-mv88de3xxx as for now, all SoCs
> Marvell is providing as DE (Digital Entertainment) fit in that. I like
> mach-codename style more than plain numbers, maybe I rename the folder
> to mach-berlin before posting.

I also like mach-berlin a bit more than mach-mve88de3xxx, for a very
silly reason: when during a discussion you have to say mach-mv88de3xxx,
it's pretty annoying. We already have the horrible mach-mv78xx0, let's
not add more of this :)

> Speaking of "berlin", they found a 2WW bomb in my home town center today
> and are evacuating apartments. Mine too, so it looks like I'll have
> some time to prepare v2 tonight..

Doh!

> > Also, to help us understand the organization of the family of SOCs, I
> > asked a few informations to Marvell, and here is what I could collect:
> >
> > """
> > BGxname		CPU core	codename	L2 cache controller	internal name
> > BG2		PJ4B		Armada1500	Tauros3			MV88DE3100
> > BG2-CT		Cortex-A9	N/A		PL310			N/A
> > BG3		Cortex-A15	N/A		CA15 integrated		N/A
> > """
> >
> > As was told that the Armada X or MV88DEx names are not used during
> > development, and what Marvell is really using are the BGxx names.
> 
> Ok, I'll add that info to Marvell SoC documentation also.

That'd be nice indeed.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
