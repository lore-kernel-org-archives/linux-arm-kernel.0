From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 17 Feb 2011 21:28:42 -0500 (EST)
Subject: The p2v branch
In-Reply-To: <alpine.LFD.2.00.1102130915120.14920@xanadu.home>
References: <alpine.LFD.2.00.1102121304500.14920@xanadu.home>
	<20110212184138.GD22402@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102121556330.14920@xanadu.home>
	<20110213114050.GB4799@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102130915120.14920@xanadu.home>
Message-ID: <alpine.LFD.2.00.1102172117230.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 Feb 2011, Nicolas Pitre wrote:

> On Sun, 13 Feb 2011, Russell King - ARM Linux wrote:
> 
> > On Sat, Feb 12, 2011 at 04:01:14PM -0500, Nicolas Pitre wrote:
> > > I've rebased my 2 patches on top of your latest p2v branch.  You may 
> > > pull them from:
> > > 
> > > 	git://git.linaro.org/people/nico/linux p2v
> > > 
> > > Or if you prefer I can put them in the patch system.
> > 
> > I'd like to wait for Catalin to respond on the phys_addr_t patch - which
> > allows 64-bit phys addresses.  Obviously that's going to have an impact
> > on the p2v code and I'd rather someone else had the job of working out
> > what to do about the T2 code.
> 
> OK.

Now rebased on top of p2v-stable, and includes the lookup_machine_type() 
cleanup patch.

Nicolas Pitre (3):
      ARM: P2V: Thumb2 support
      ARM: ignore mdesc->boot_params if out of range
      ARM: fold lookup_machine_type() into setup_machine()

 arch/arm/Kconfig        |    4 +-
 arch/arm/kernel/head.S  |   49 ++++++++++++++++++++++++++++-
 arch/arm/kernel/setup.c |   69 +++++++++++++++++++++-------------------
 3 files changed, 86 insertions(+), 36 deletions(-)


Nicolas
