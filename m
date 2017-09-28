From: kalyan.kinthada@alliedtelesis.co.nz (Kalyan Kinthada)
Date: Thu, 28 Sep 2017 17:04:05 +1300
Subject: [PATCH 0/2] Fix I2C repeated start timing violation on Armada-38x.
Message-ID: <20170928040407.8933-1-kalyan.kinthada@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the Armada 38x(380, 385, 388) have a silicon issue in
the I2C controller which violates the I2C repeated start timing
(errata FE-8471889).

Activate the compatible string "marvell,mv78230-a0-i2c" in the
device tree file of Armada-38x to fx this errata (FE-8471889).

Updated the Documentation for the compatible string
"marvell,mv78230-a0-i2c" by removing the "notes" because
this is applicable for a number of SoCs such as early revisions
of Armada XP and the Armada 38x variants.

Thank You Gregory Clement for suggesting to reuse the
"marvell,mv78230-a0-i2c" compatible string on Armada-38x SoCs.

------
Kalyan Kinthada (2):
  ARM: dts: Fix I2C repeated start issue on Armada-38x
  dt-bindings: i2c: Update documentation for "mv78230-a0-i2c"

 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 4 ----
 arch/arm/boot/dts/armada-38x.dtsi                     | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.14.1
