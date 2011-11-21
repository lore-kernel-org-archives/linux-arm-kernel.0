From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2011 09:56:58 +0000
Subject: [01: PATCH 0/7] Preparation for arch_reset changes
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <20111121095658.GO9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of today, I'm going to start freezing the restart changes, which
covers those which have been in linux-next so far.  I've collected up
all the acks, etc, to date, and will not be applying any more to these
commits.

At the end of today, I'll merge these into my 'devel-stable' branch
to signify their new status, so if anyone has any objections they need
to speak up _now_.

The base set of changes are:

ARM: restart: only perform setup for restart when soft-restarting
ARM: restart: remove argument to setup_mm_for_reboot()
ARM: restart: move reboot failure handing into machine_restart()
ARM: restart: add default restart modes for PXA mioa701, spitz and tosa
ARM: restart: allow platforms more flexibility specifying restart mode
ARM: restart: add restart hook to machine_desc record

and the cleanups to prepare for the rest of the restart changes:

ARM: restart: remove poodle restart handler
ARM: w90x900: add common nuc9xx.h
ARM: clps711x: consolidate irq/mm/time code into a single file
ARM: 7159/1: OMAP: Introduce local common.h files
ARM: restart: remove local_irq_disable() from within arch_reset()
