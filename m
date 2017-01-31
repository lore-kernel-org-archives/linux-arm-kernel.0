From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Jan 2017 12:19:49 +0000
Subject: [PATCH 0/7] arm64: arch_timer: work around Hisilicon erratum 161010101
Message-ID: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches are a rework of Ding's v9 series [1], addessing some issues with
code style and the commit logs.

Daniel, are you happy to take a look over these?

Catalin, Will, to minimise conflict with the Falkor erratum workaround, I've
added a preparatory patch that simply widens the silicon-errata kconfig column,
which should be queued before either patch.

Would you be happy with that patch going via both the arm64 tree and the
clocksource tree? We need it via the latter for the Hisilicon erratum 161010101
documentation, unless we split the documentation from the code.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/481089.html

Ding Tianhong (6):
  arm64: arch_timer: add dt binding for hisilicon-161010101 erratum
  arm64: arm_arch_timer: remove fsl-a008585 parameter
  arm64: arch_timer: introduce generic errata handling infrastructure
  arm64: arch_timer: work around Hisilicon erratum 161010101
  arm64: arch_timer: document Hisilicon erratum 161010101
  arm64: arch timer: Add timer erratum property for Hip05-d02 and
    Hip06-d03

Mark Rutland (1):
  arm64: docs: widen silicon-errata kconfig column

 Documentation/admin-guide/kernel-parameters.txt    |   9 --
 Documentation/arm64/silicon-errata.txt             |  44 +++---
 .../devicetree/bindings/arm/arch_timer.txt         |   6 +
 arch/arm64/boot/dts/hisilicon/hip05.dtsi           |   1 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |   1 +
 arch/arm64/include/asm/arch_timer.h                |  38 ++----
 drivers/clocksource/Kconfig                        |  14 ++
 drivers/clocksource/arm_arch_timer.c               | 151 +++++++++++++++------
 8 files changed, 168 insertions(+), 96 deletions(-)

-- 
1.9.1
