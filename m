From: joelagnel@ti.com (Joel A Fernandes)
Date: Tue, 25 Jun 2013 20:23:28 -0500
Subject: [PATCH 0/5] AM33xx: MMC resources from DT without HWMOD data
Message-ID: <1372209808-6532-1-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel A Fernandes <agnel.joel@gmail.com>

This series is fixes to get MMC working on AM33XX without HWMOD data.
On removal of HWMOD data, interrupt and register properties need to be provided
for the driver to function correctly.

Also instead of specifying offset in match->data, I've added bindings for the
same and specify it directly from DT as this is a hardware description.

Reposting Matt's remaining 2 patches on the bindings and dts.

Joel A Fernandes (3):
  MMC: omap_hsmmc: Add reg_offset to DT bindings
  ARM: dts: am33xx: Add interrupts and memory resources for MMC
  mmc: omap_hsmmc: Add reg-offset to bindings documentation

Matt Porter (2):
  ARM: dts: add AM33XX MMC support
  mmc: omap_hsmmc: add generic DMA request support to the DT binding

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   29 +++++++++++++-
 arch/arm/boot/dts/am335x-bone.dts                  |    7 ++++
 arch/arm/boot/dts/am335x-evm.dts                   |    7 ++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |    7 ++++
 arch/arm/boot/dts/am33xx.dtsi                      |   40 ++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c                      |    7 +++-
 6 files changed, 95 insertions(+), 2 deletions(-)

-- 
1.7.9.5
