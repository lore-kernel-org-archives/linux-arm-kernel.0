From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 11 Jun 2011 15:18:31 +0200
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <20110611124955.GA2983@riccoc20.at.omicron.at>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<20110601225826.GR3660@n2100.arm.linux.org.uk>
	<20110611051510.GA3283@riccoc20.at.omicron.at>
	<19955.20458.788309.51588@pilspetsen.it.uu.se>
	<20110611124955.GA2983@riccoc20.at.omicron.at>
Message-ID: <19955.27431.578971.917957@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Cochran writes:
 > >  > I understand (or have been told) that almost all arm implementations
 > >  > out there are little endian. Why not use use a normal load to read the
 > >  > timer? Are there machines with LE peripheral buses but BE cores?
 > > 
 > > ARM cores often have software-controllable endianess (see the ARM ARM).
 > > Off the top of my head:
 > > - ixp4xx: natively BE core and peripherals, but some people like to
 > >   switch the core to LE for user-space SW compatibility reasons
 > >   (I run my ixp4xx in BE as intended though)
 > > - Kirkwood: natively LE core and peripherals, but the core is switchable
 > >   to BE, although driver support for that appears to be incomplete
 > 
 > So, would you say that using le_to_cpu in the MMIO clocksource reading
 > functions makes good sense, or not?

There has to be a place for optional endianess conversion (le_to_cpu,
be_to_cpu, or none at all) somewhere in the MMIO access paths, and it
has to be controlled by platform code.  I don't know the new clocksource
code well enough to suggest exactly where that should be done.
