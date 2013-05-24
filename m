From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 May 2013 01:45:03 -0400
Subject: [PATCH 0/8] MCPM support for big.LITTLE Virtual Express RTSM
Message-ID: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements an MCPM backend for the Virtual Express b.L RTSM model.

This series was partially reviewed during previous posting of some
components in the past, but some new parts were added to improve
the whole thing.

Diffstat:

 Documentation/devicetree/bindings/arm/cci.txt   | 169 ++++++
 .../devicetree/bindings/arm/rtsm-dcscb.txt      |  19 +
 arch/arm/include/asm/cp15.h                     |  14 +
 arch/arm/mach-vexpress/Kconfig                  |   9 +
 arch/arm/mach-vexpress/Makefile                 |   1 +
 arch/arm/mach-vexpress/dcscb.c                  | 255 +++++++++
 arch/arm/mach-vexpress/dcscb_setup.S            |  38 ++
 drivers/bus/Kconfig                             |   7 +
 drivers/bus/Makefile                            |   2 +
 drivers/bus/arm-cci.c                           | 529 ++++++++++++++++++
 drivers/cpuidle/cpuidle-calxeda.c               |  14 +-
 include/linux/arm-cci.h                         |  61 ++
 12 files changed, 1105 insertions(+), 13 deletions(-)
