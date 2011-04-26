From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2011 16:05:26 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <alpine.LFD.2.00.1104211629300.24613@xanadu.home>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110421201455.GA18083@redhat.com>
	<alpine.LFD.2.00.1104211629300.24613@xanadu.home>
Message-ID: <201104261605.26791.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2011, Nicolas Pitre wrote:
> > if there's commonality between some of the ARM arch drivers, why can't
> > there be a arch/arm/cpufreq/ dir for the shared code, and do everything there ?
> 
> Because usually there isn't.  "ARM" is just a CPU architecture, not a 
> system architecture.  Everything around the core is different from one 
> vendor to the next.  And when commonality exists it is much easier to 
> deal with if it is close together.

Exactly. To make matters worse, we are starting to see a number of vendors
that use multiple CPU architectures with the same I/O devices (e.g. Renesas,
Freescale, Xilinx, TI, ...). Not sure if any of these use the same cpufreq
register on more than one architecture, but it's quite likely to happen
at some point.

	Arnd
