From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 26 Apr 2011 19:04:45 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <201104261605.26791.arnd@arndb.de>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104211629300.24613@xanadu.home>
	<201104261605.26791.arnd@arndb.de>
Message-ID: <201104261904.45923.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 26, 2011, Arnd Bergmann wrote:
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

Indeed.  So in my opinion it makes sense to move code into the drivers
directory, at least the code that's going to be used by multiple platforms
(that need not be a complete driver).

We're doing the same thing with the runtime PM code at the moment.

Thanks,
Rafael
