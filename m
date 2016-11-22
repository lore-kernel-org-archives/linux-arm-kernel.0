From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 22 Nov 2016 17:48:40 +0100
Subject: [PATCH net-next 0/4] Extend mvneta to support Armada 3700 (ARM 64)
Message-ID: <20161122164844.19566-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series enable the use of mvneta driver on the Armada 3700
SoCs. Armada 3700 is a new ARMv8 SoC from Marvell using same network
controller as older Armada 370/38x/XP.

Besides the changes needed to be used on 64-bits architecture done in
the 1st patch, there are also few difference related to the Armada
3700 SoC. The main one being the used of shared interrupt instead of
the private ones. It has been addressed in the 3rd patch.

Not all the feature supported on the older Soc have been ported yet
for this new SoC.

Gregory CLEMENT (2):
  net: mvneta: Only disable mvneta_bm for 64-bits
  ARM64: dts: marvell: Add network support for Armada 3700

Marcin Wojtas (2):
  net: mvneta: Convert to be 64 bits compatible
  net: mvneta: Add network support for Armada 3700 SoC

 .../bindings/net/marvell-armada-370-neta.txt       |   7 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |  23 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  23 ++
 drivers/net/ethernet/marvell/Kconfig               |  10 +-
 drivers/net/ethernet/marvell/mvneta.c              | 364 ++++++++++++++++-----
 5 files changed, 333 insertions(+), 94 deletions(-)

-- 
2.10.2
