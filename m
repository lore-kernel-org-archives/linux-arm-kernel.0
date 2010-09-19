From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Sep 2010 19:09:46 +0200
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <20100919164040.GG9098@n2100.arm.linux.org.uk>
References: <cover.1284655723.git.mike@compulab.co.il>
	<201009191834.44928.arnd@arndb.de>
	<20100919164040.GG9098@n2100.arm.linux.org.uk>
Message-ID: <201009191909.46371.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 September 2010 18:40:40 Russell King - ARM Linux wrote:
> which works fine - and yes, if you insert an ISA driver it probably will
> crash.  But then you can crash an x86 PC by using setserial to define
> a serial port at a wrong address.

Sure, if you build the kernel just for one machine, there is no reason
to include code that tries to access fixed I/O ports.

What I'm more worried about is that as we're moving to multi-platform
kernels you want to build for other hardware, e.g. one that has
a PC-style keyboard controller and one that has a funny mapping like that.

Normally, the driver for the keyboard controller should just access
the well-known port number and not find anything there, because PCI
devices are mapped above port 0x1000. What you get instead is a kernel
NULL pointer access.

	Arnd
