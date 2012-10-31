From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Oct 2012 14:17:10 -0500
Subject: [GIT PULL] Calxeda ECX-2000 support
Message-ID: <50917936.2030405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull support for Calxeda ECX-2000 SOC.

There will be a trivial conflict with the GIC move to drivers/irqchip once
that goes in. 

Rob

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git tags/calxeda-ecx-2000

for you to fetch changes up to e095c0d122c09efabe7d4136ce77f72c636c4879:

  ARM: highbank: Add initial ECX-2000 support (2012-10-31 13:47:01 -0500)

----------------------------------------------------------------
Support for Calxeda ECX-2000 SOC

----------------------------------------------------------------
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
