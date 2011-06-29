From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:20:13 +0100
Subject: [PATCH 00/23] entry assembly cleanups
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <20110629092013.GA10876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, here's the overall diffstat:

 arch/arm/include/asm/entry-macro-multi.S         |   14 +-
 arch/arm/kernel/entry-armv.S                     |  271 +++++++++-------------
 arch/arm/kernel/entry-header.S                   |   19 --
 arch/arm/kernel/hw_breakpoint.c                  |    6 +-
 arch/arm/mach-bcmring/include/mach/entry-macro.S |    4 -
 arch/arm/mach-davinci/include/mach/entry-macro.S |    3 -
 arch/arm/mach-h720x/include/mach/entry-macro.S   |    3 -
 arch/arm/mach-lpc32xx/include/mach/entry-macro.S |    4 -
 arch/arm/mach-omap2/include/mach/entry-macro.S   |    3 -
 arch/arm/mach-pnx4008/include/mach/entry-macro.S |    5 -
 arch/arm/mach-shark/include/mach/entry-macro.S   |   10 +-
 arch/arm/mm/abort-ev4.S                          |   17 +-
 arch/arm/mm/abort-ev4t.S                         |   17 +-
 arch/arm/mm/abort-ev5t.S                         |   19 +-
 arch/arm/mm/abort-ev5tj.S                        |   25 +--
 arch/arm/mm/abort-ev6.S                          |   25 +--
 arch/arm/mm/abort-ev7.S                          |   25 +--
 arch/arm/mm/abort-lv4t.S                         |  141 ++++++------
 arch/arm/mm/abort-macro.S                        |   34 ++--
 arch/arm/mm/abort-nommu.S                        |   10 +-
 arch/arm/mm/alignment.c                          |    3 +
 arch/arm/mm/fault.c                              |    4 +
 arch/arm/mm/pabort-legacy.S                      |   10 +-
 arch/arm/mm/pabort-v6.S                          |   10 +-
 arch/arm/mm/pabort-v7.S                          |   11 +-
 arch/arm/mm/proc-arm6_7.S                        |   90 ++++----
 arch/arm/plat-mxc/include/mach/entry-macro.S     |    4 -
 27 files changed, 333 insertions(+), 454 deletions(-)
