From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  8 Jul 2015 17:02:29 +0200
Subject: [PATCHv2 0/8] ARM: mvebu: add suspend to RAM support for Armada 38x
Message-ID: <1436367757-14202-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the v2 of the patch series adding suspend to RAM support for
Armada 38x.

Since v1 (posted June 16th) :

 - Rebased on top of v4.2-rc1, so dropped the patch "ARM: mvebu: fix
   suspend to RAM on big-endian configurations" which was merged.

 - Added Acked-by from Gregory Clement on the relevant patches.

 - Fixed the Armada 388 GP board name in the "model" property of the
   DT, as suggested by Gregory Clement.

Thanks,

Thomas

Nadav Haklai (1):
  ARM: mvebu: prepare set_cpu_coherent() for future extension

Thomas Petazzoni (7):
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
 arch/arm/mach-mvebu/pm-board.c      | 25 +++++++-------
 arch/arm/mach-mvebu/pm.c            | 69 +++++++++++++++++++++++++++++++++----
 arch/arm/mach-mvebu/pmsu.h          |  1 +
 arch/arm/mach-mvebu/pmsu_ll.S       | 43 +++++++++++++++++++++++
 8 files changed, 165 insertions(+), 34 deletions(-)

-- 
2.4.5
