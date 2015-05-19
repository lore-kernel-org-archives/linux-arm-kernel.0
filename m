From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 May 2015 00:03:49 +0200
Subject: [PATCH soc v8 0/3] ARM: vf610m4: Add Vybrid Cortex-M4 support
Message-ID: <1432073032-26561-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the soc part of the splitted patchset which enables Cortex-M4
support on Vybrid, as discussed in the thread of patchset v7.

Changes since v7:
- Split version for arm-soc
- Default to debug/uncompress.h for ARM_SINGLE_ARMV7M initially
- Drop EFM32 conversion (will be part of a follow-up patch)

Stefan Agner (3):
  ARM: unify MMU/!MMU addruart calls
  ARM: introduce ARM_SINGLE_ARMV7M for ARMv7-M platforms
  ARM: vf610: enable Cortex-M4 configuration on Vybrid SoC

 Documentation/devicetree/bindings/arm/fsl.txt |  3 +++
 arch/arm/Kconfig                              | 13 +++++++++
 arch/arm/Kconfig.debug                        |  5 ++--
 arch/arm/include/debug/efm32.S                |  2 +-
 arch/arm/kernel/debug.S                       |  2 +-
 arch/arm/mach-imx/Kconfig                     | 38 +++++++++++++++------------
 arch/arm/mach-imx/Makefile.boot               |  0
 arch/arm/mach-imx/mach-vf610.c                |  1 +
 8 files changed, 43 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/mach-imx/Makefile.boot

-- 
2.4.1
