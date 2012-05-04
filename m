From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 14:41:24 +0000
Subject: [RFC] Remove support for ARMv3 ARM610 and ARM710 CPUs
In-Reply-To: <20120504095645.GD26481@n2100.arm.linux.org.uk>
References: <20120504095645.GD26481@n2100.arm.linux.org.uk>
Message-ID: <201205041441.24573.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Russell King - ARM Linux wrote:
> This patch removes support for ARMv3 CPUs, which haven't worked properly
> for quite some time (see the FIXME comment in arch/arm/mm/fault.c).  The
> only V3 parts left is the cache model for ARMv3, which is needed for some
> odd reason by ARM740T CPUs, and being able to build with -march=armv3,
> which is required for the RiscPC platform due to its bus structure.

No objections to the patch, but I wonder if this change obsoletes any
hardware drivers in turn.  Are there any RiscPC peripherals that are
only available on the older models?

	Arnd
