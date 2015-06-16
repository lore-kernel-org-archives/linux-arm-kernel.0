From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Jun 2015 14:12:56 +0200
Subject: [PATCH 0/9] ARM: mvebu: add suspend to RAM support for Armada 38x
Message-ID: <1434456785-23696-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds suspend to RAM support for the Armada 38x SoC,
and especially the Armada 388 GP board. It has been tested on Armada
XP GP little and big endian, and on Armada 388 GP little and big
endian.

The first patch is really a fix, that makes Armada XP GP suspend to
RAM work in big endian configurations.

Then patches 2 to 5 are preparation patches, and patches 6 to 9
implement the suspend/resume support for Armada 38x itself, with first
the code changes, and then the Device Tree changes.

This is obviously not intended for 4.2, but for 4.3.

Best regards,

Thomas

Nadav Haklai (1):
  ARM: mvebu: prepare set_cpu_coherent() for future extension

Thomas Petazzoni (8):
  ARM: mvebu: fix suspend to RAM on big-endian configurations
  ARM: mvebu: do not check machine in mvebu_pm_init()
  ARM: mvebu: prepare mvebu_pm_store_bootinfo() to support multiple SoCs
  ARM: mvebu: prepare pm-board.c for the introduction of Armada 38x
    support
  ARM: mvebu: add suspend/resume support for Armada 38x
  ARM: mvebu: add suspend/resume related definitions in Armada 38x
    Device Tree
  ARM: mvebu: add suspend/resume DT information for Armada 388 GP
  ARM: mvebu: adjust board name and compatible for Armada 388 GP

 arch/arm/boot/dts/armada-388-gp.dts | 20 +++++++++--
 arch/arm/boot/dts/armada-38x.dtsi   |  7 +++-
 arch/arm/mach-mvebu/board-v7.c      |  1 +
 arch/arm/mach-mvebu/coherency.c     | 33 +++++++++++-------
 arch/arm/mach-mvebu/pm-board.c      | 28 ++++++++-------
 arch/arm/mach-mvebu/pm.c            | 69 +++++++++++++++++++++++++++++++++----
 arch/arm/mach-mvebu/pmsu.h          |  1 +
 arch/arm/mach-mvebu/pmsu_ll.S       | 43 +++++++++++++++++++++++
 8 files changed, 168 insertions(+), 34 deletions(-)

-- 
2.1.0
