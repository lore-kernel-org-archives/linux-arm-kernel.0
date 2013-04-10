From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 10 Apr 2013 15:19:33 -0400 (EDT)
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410190603.GL14496@n2100.arm.linux.org.uk>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304101307280.17375@syhkavp.arg>
 <20130410190052.GC18196@blackmetal.musicnaut.iki.fi>
 <20130410190603.GL14496@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304101510230.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Apr 2013, Russell King - ARM Linux wrote:

> On Wed, Apr 10, 2013 at 10:00:52PM +0300, Aaro Koskinen wrote:
> > Menuconfig mentions under "Floating point emulation" that "At least one
> > emulation must be selected". But if I compile my OS with EABI userspace
> > soft-float I guess I won't actually need to select any emulation,
> > or have I missed something? (I just checked my configs, and at least
> > on Kirkwood/openrd I have been already running without any emulation,
> > so I guess the help text is wrong?)
> 
> Well, it's that way to stop us being flooded with "why does my kernel
> stop after mounting the rootfs" questions.  Maybe that can be changed
> now, it depends whether we're absolutely certain that there's no FPA
> instructions in any binary being run on EABI-only userspaces.

It is at least clear according to the EABI documentation. The double 
float word ordering is also defined to be different from FPA's, making 
EABI and FPA incompatible.

> Given that such instructions will still be emulated if they're
> encountered, I think we need to have another option to at least report
> an error via the kernel message log should a FPA instruction be trapped.

Agreed.


Nicolas
