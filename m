From: robherring2@gmail.com (Rob Herring)
Date: Fri, 26 Oct 2012 13:43:02 -0500
Subject: [PATCH 0/6] Initial Calxeda ECX-2000 support
Message-ID: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series adds initial support for Calxeda A15 based ECX-2000 SOC. Most
of the changes are shuffling of dts files to share common parts between
highbank (ECX-1000) and ECX-2000 and abstracting out or removing SCU
accesses as the A15 has no SCU registers.

Although the highbank name really refers to 1st gen SOC, the highbank
name in the kernel is now referring to both SOCs.

Rob

Rob Herring (6):
  ARM: highbank: disable unused sdhci and gpio in dts
  ARM: highbank: enable coherent DMA for xgmac in dts
  ARM: dts: Add Calxeda ECX-2000 support
  ARM: smp_twd: don't warn on no DT node
  ARM: highbank: abstract out SCU usage
  ARM: highbank: Add initial ECX-2000 support

 Documentation/devicetree/bindings/arm/calxeda.txt |   13 +-
 arch/arm/boot/dts/Makefile                        |    3 +-
 arch/arm/boot/dts/ecx-2000.dts                    |  104 +++++++++
 arch/arm/boot/dts/ecx-common.dtsi                 |  237 +++++++++++++++++++++
 arch/arm/boot/dts/highbank.dts                    |  212 +-----------------
 arch/arm/kernel/smp_twd.c                         |    6 +-
 arch/arm/mach-highbank/Kconfig                    |    2 +-
 arch/arm/mach-highbank/highbank.c                 |   27 +--
 arch/arm/mach-highbank/hotplug.c                  |    6 +-
 arch/arm/mach-highbank/platsmp.c                  |    7 +-
 arch/arm/mach-highbank/pm.c                       |    3 -
 arch/arm/mach-highbank/sysregs.h                  |   19 ++
 arch/arm/mach-highbank/system.c                   |    2 -
 13 files changed, 394 insertions(+), 247 deletions(-)
 create mode 100644 arch/arm/boot/dts/ecx-2000.dts
 create mode 100644 arch/arm/boot/dts/ecx-common.dtsi

-- 
1.7.10.4
