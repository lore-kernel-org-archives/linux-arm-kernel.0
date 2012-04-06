From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 06 Apr 2012 09:52:24 +0100
Subject: [PATCH 4/7 v4] ARM: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <20120405224143.GL817@titan.lakedaemon.net>
References: <cover.1331601448.git.jason@lakedaemon.net>
 <0032addd7e94c5d4d1a3a0be77fe79bcffee53db.1331601448.git.jason@lakedaemon.net>
 <1333663656.12209.62.camel@dagon.hellion.org.uk>
 <20120405224143.GL817@titan.lakedaemon.net>
Message-ID: <1333702344.12209.70.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-04-05 at 18:41 -0400, Jason Cooper wrote:
> On Thu, Apr 05, 2012 at 11:07:36PM +0100, Ian Campbell wrote:
> > On Tue, 2012-03-13 at 01:57 +0000, Jason Cooper wrote:
> > > +DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)") 
> > 
> > This ends up as Machine: in /proc/cpuinfo, which seems to be normal?
> > 
> > Would it be worth trying to dynamically modify the machine string based
> > on the actual hardware the kernel is running on?
> 
> With CONFIG_PROC_DEVICETREE=y I get the following:
> 
> $ cat /proc/device-tree/model
> Globalscale Technologies Dreamplug

Yes, I just found that, thanks.

BTW the impetus for my asking was http://bugs.debian.org/667681 against
the flash-kernel tool which uses /proc/cpuinfo to know what magic runes
are required for the particular board it is being run on.

> It seems to me (I have no strong opinion here, just playing devil's
> advocate) that /proc/cpuinfo is indeed telling us about the processor
> (Marvell Kirkwood ...) Should it really be describing the board?

The field is actually called "Hardware:" (not "Machine:" as I said
above). Processor is actually covered separately ("Feroceon 88FR131 rev
1 (v5l)" in this case). I'd expect Hardware: to say something more
specific about the h/w platform, the string from /proc/device-tree/model
is exactly what I think I would have expected.

Ian.

> 
> thx,
> 
> Jason.
> 

-- 
Ian Campbell


Nostalgia isn't what it used to be.
