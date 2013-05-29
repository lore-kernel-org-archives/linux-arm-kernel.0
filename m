From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 29 May 2013 16:21:49 -0400 (EDT)
Subject: [GIT PULL] MCPM support for VExpress RTSM
Message-ID: <alpine.LFD.2.03.1305291604300.30828@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARnd, Olof, please pull the following:

	git://git.linaro.org/people/nico/linux VExpress_DCSCB

This is the first MCPM backend submission for VExpress running on RTSM 
aka Fast Models implementing the big.LITTLE system architecture.  This 
enables SMP secondary boot as well as CPU hotplug on this platform.

A big prerequisite for this support is the CCI driver from Lorenzo 
included in this pull request.

Also included is Rob Herring's set_auxcr/get_auxcr allowing nicer code.

This is based on RMK's current devel-stable branch as this code also 
relies on commit b382b940f821 to work properly.

The diffstat follows:

 Documentation/devicetree/bindings/arm/cci.txt   | 172 ++++++
 .../devicetree/bindings/arm/rtsm-dcscb.txt      |  19 +
 arch/arm/include/asm/cp15.h                     |  14 +
 arch/arm/mach-vexpress/Kconfig                  |   9 +
 arch/arm/mach-vexpress/Makefile                 |   1 +
 arch/arm/mach-vexpress/core.h                   |   2 +
 arch/arm/mach-vexpress/dcscb.c                  | 253 +++++++++
 arch/arm/mach-vexpress/dcscb_setup.S            |  38 ++
 arch/arm/mach-vexpress/platsmp.c                |  20 +
 arch/arm/mach-vexpress/v2m.c                    |   1 +
 drivers/bus/Kconfig                             |   7 +
 drivers/bus/Makefile                            |   2 +
 drivers/bus/arm-cci.c                           | 533 ++++++++++++++++++
 drivers/cpuidle/cpuidle-calxeda.c               |  14 -
 include/linux/arm-cci.h                         |  61 ++
 15 files changed, 1132 insertions(+), 14 deletions(-)


Nicolas
