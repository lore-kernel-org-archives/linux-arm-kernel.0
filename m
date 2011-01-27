From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:45:32 +0000
Subject: [PATCH 00/11] Rationalize and consolidate ARMs evaluation boards
Message-ID: <20110127134532.GE25968@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series, which applies on top of the CLCD series consolidates some
of the code used on ARM platforms, in particular the FPGA interrupt,
local timer, and SMP bring up code.

We also add sched_clock() support for Integrator/CP, but only when we're
building only for Integrator/CP as Integrator/AP platforms don't have
the 24MHz counter.  We also move the sched_clock() initialization to
the early init callback, along with registering the clock lookups.

As we know how DMA is to be supported with primecells, we no longer need
the DMA definitions which aren't used, so these are removed.
