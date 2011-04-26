From: davej@redhat.com (Dave Jones)
Date: Tue, 26 Apr 2011 14:15:08 -0400
Subject: Status of arch/arm in linux-next
In-Reply-To: <201104261904.45923.rjw@sisk.pl>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104211629300.24613@xanadu.home>
	<201104261605.26791.arnd@arndb.de> <201104261904.45923.rjw@sisk.pl>
Message-ID: <20110426181508.GB1908@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2011 at 07:04:45PM +0200, Rafael J. Wysocki wrote:
 > On Tuesday, April 26, 2011, Arnd Bergmann wrote:
 > > On Thursday 21 April 2011, Nicolas Pitre wrote:
 > > > > if there's commonality between some of the ARM arch drivers, why can't
 > > > > there be a arch/arm/cpufreq/ dir for the shared code, and do everything there ?
 > > > 
 > > > Because usually there isn't.  "ARM" is just a CPU architecture, not a 
 > > > system architecture.  Everything around the core is different from one 
 > > > vendor to the next.  And when commonality exists it is much easier to 
 > > > deal with if it is close together.
 > > 
 > > Exactly. To make matters worse, we are starting to see a number of vendors
 > > that use multiple CPU architectures with the same I/O devices (e.g. Renesas,
 > > Freescale, Xilinx, TI, ...). Not sure if any of these use the same cpufreq
 > > register on more than one architecture, but it's quite likely to happen
 > > at some point.
 > 
 > Indeed.  So in my opinion it makes sense to move code into the drivers
 > directory, at least the code that's going to be used by multiple platforms
 > (that need not be a complete driver).

Ok, so my opinion on this has changed a little over the weekend.
I don't totally hate it now, but I'm still not a huge fan.
That said, I won't stand in the way if this is what everyone agrees is
the way forward.

in cpufreq.next I moved the x86 drivers over.  Someone look it over ?
If that looks like what you all had in mind, start sending me the patches
for other arches, and I'll get them queued up for .40

	Dave
