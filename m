From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sun, 04 Oct 2009 02:14:13 +0100
Subject: [RFC][PATCH  v1.0] Update and enhance TS-7XXX support
Message-ID: <20091004011413.12578.89897.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the very first patch needed to uptdate and enhance support for the 
TS-72XX boards (See http://www.embeddedarm.com).

These few patches are the ones that affect all EP93XX platforms. As I'm sure 
they are not yet quite right for now, any comments are very welcome.

These patch have been collected and maintained mainly by Matthieu Crapet 
(http://mcrapet.free.fr/). Tests and contributions are made by the community 
on yahoo groups (http://tech.groups.yahoo.com/group/ts-7000).

Thanks to Russel King for spoting the bug that made the sparsemem patch useless.
Now we can enjoy a recent kernel with 64MB of RAM! :)

Patch set statistics:
 arch/arm/Kconfig                                |    1 +
 arch/arm/include/asm/memory.h                   |    2 ++
 arch/arm/kernel/head.S                          |    3 ++
 arch/arm/mach-ep93xx/Kconfig                    |   16 ++++++++++++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   15 ++++++++++++
 arch/arm/mach-ep93xx/include/mach/memory.h      |   30 +++++++++++++++++++++++
 arch/arm/mm/proc-arm920.S                       |    3 ++
 7 files changed, 70 insertions(+), 0 deletions(-)
