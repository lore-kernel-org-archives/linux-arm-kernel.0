From: rogerq@ti.com (Roger Quadros)
Date: Tue, 18 Jun 2013 14:11:27 +0300
Subject: [PATCH 0/4] ARM: OMAP4: Panda USB Host support and DVI EDID fix
Message-ID: <1371553891-29364-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit & Tony,

The first two patches make changes to dts files to get USB host support
and DVI EDID to work on Panda.

The third patch should get USB host functional on uEVM.

The fourth patch is a temporary workaround to create a clock alias to
the USB PHY clock as it is not possible to define this via device tree.
This patch is required for USB host to work on Panda and uEVM.

The first 3 patches are for Benoit and the last one is for Tony.

cheers,
-roger

Roger Quadros (4):
  ARM: dts: omap4-panda: Add USB Host support
  ARM: dts: omap4-panda: Fix DVI EDID reads
  ARM: dts: omap5-uevm: Provide USB Host PHY clock frequency
  ARM: OMAP2+: dts: HACK: Provide alias to USB PHY clock

 arch/arm/boot/dts/omap4-panda-common.dtsi |   67 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5-uevm.dts          |    7 +++
 arch/arm/mach-omap2/board-generic.c       |   23 +++++++++-
 3 files changed, 96 insertions(+), 1 deletions(-)

-- 
1.7.4.1
