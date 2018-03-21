From: tmaimon77@gmail.com (Tomer Maimon)
Date: Wed, 21 Mar 2018 17:36:16 +0200
Subject: [PATCH v1 0/1] arm: dts: add Nuvoton NPCM750 device tree
Message-ID: <1521646577-10773-1-git-send-email-tmaimon77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NPCM7xx are a family of BMC's that include several chips as:
NPCM750, NPCM730 etc.

All of the NPCM7xx BMC's have the common modules like Cortex-A9,
WDT, timers, etc, and there are a optional modules that can be added.

NPCM750 device tree already pushed to arm-soc.git:
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=for-next&id=d6bdd009c21db3f677dd1d1bbb8c20bc819074bc

After discussion with Rob Herring we have modified the structure
of the NPCM7xx device tree as follow:

nuvoton-common-npcm7xx device tree include all common modules
nuvoton-npcm750 device tree include specific npcm750 modules, 
the nuvoton-npcm750 device tree include nuvoton-common-npcm7xx device tree

In addition, the NPCM7xx device tree include the following changes:
	- watchdog module added 
	- clock module modification
	- serial module modification

I will like to replace the device tree that pushed to arm-soc.git with
this patch set.

Please review it, sorry if it cause more work after pushing 
NPCM750 device tree.

Thanks a lot,

Tomer

Tomer Maimon (1):
  arm: dts: add Nuvoton NPCM750 device tree

 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 187 ++++++++++++++++++++++++++
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts     |  39 ++++++
 arch/arm/boot/dts/nuvoton-npcm750.dtsi        |  45 +++++++
 4 files changed, 273 insertions(+)
 create mode 100644 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-evb.dts
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi

-- 
2.14.1
