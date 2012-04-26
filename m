From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 11:52:48 -0600
Subject: [PATCH 1/4] ARM: dt: tegra seaboard: fix I2C2 SCL rate
Message-ID: <1335462771-21791-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This I2C bus is used for EDID/DDC reads and other "slow" I2C devices.
This requires a 100KHz SCL (clock) rate.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-seaboard.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index e188925..96516fb 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -281,7 +281,7 @@
 	};
 
 	i2c at 7000c400 {
-		clock-frequency = <400000>;
+		clock-frequency = <100000>;
 	};
 
 	i2c at 7000c500 {
-- 
1.7.0.4
