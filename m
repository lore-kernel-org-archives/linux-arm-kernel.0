From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 2 May 2011 00:02:13 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <201104261605.26791.arnd@arndb.de>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110421201455.GA18083@redhat.com>
	<alpine.LFD.2.00.1104211629300.24613@xanadu.home>
	<201104261605.26791.arnd@arndb.de>
Message-ID: <20110501230213.GG5832@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> On Thursday 21 April 2011, Nicolas Pitre wrote:
> > > if there's commonality between some of the ARM arch drivers, why can't
> > > there be a arch/arm/cpufreq/ dir for the shared code, and do everything there ?
> > 
> > Because usually there isn't.  "ARM" is just a CPU architecture, not a 
> > system architecture.  Everything around the core is different from one 
> > vendor to the next.  And when commonality exists it is much easier to 
> > deal with if it is close together.
> 
> Exactly. To make matters worse, we are starting to see a number of vendors
> that use multiple CPU architectures with the same I/O devices (e.g. Renesas,
> Freescale, Xilinx, TI, ...). Not sure if any of these use the same cpufreq
> register on more than one architecture, but it's quite likely to happen
> at some point.

Can't comment on in-tree SoCs, but out of tree (they use Linux but
don't submit anything upstream as far as I can tell), Sigma Designs
use ARM & MIPS CPU architectures, with the clock/timing registers, irq
registers and more or less everything else being the same among them.

-- Jamie
