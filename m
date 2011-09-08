From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 08 Sep 2011 16:54:31 -0400 (EDT)
Subject: [RFC PATCH 0/3] Per SoC descriptor
In-Reply-To: <8605786.uz70QLLSTu@wuerfel>
References: <1315501212-1820-1-git-send-email-marc.zyngier@arm.com>
	<8605786.uz70QLLSTu@wuerfel>
Message-ID: <alpine.LFD.2.00.1109081649370.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Sep 2011, Arnd Bergmann wrote:

> On Thursday 08 September 2011 18:00:09 Marc Zyngier wrote:
> > This is my first stab at an idea that has floated around for a while,
> > which is to have a per-soc descriptor containing most of the SoC
> > specific operations, which should clear the path a bit more towards
> > the single zImage holy grail. It's as far as possible from being
> > perfect, but I thought I'd share it as early as possible and see what
> > people think of it.
> > 
> > This first patch series introduces the arm_soc_desc structure, adds
> > per-soc SMP and CPU hotplug operations, and converts both RealView and
> > VExpress to this new scheme.
> 
> Very nice, I definitely like the concept! This is going to be really
> helpful reducing the amount of stuff we need in machine descriptors.

Agreed.  And starting up with things that are not already in the 
per-machine descriptor is a good move.  Once this is well established 
then we might consider moving some features over from the machine desc 
to this SOC desc.


Nicolas
