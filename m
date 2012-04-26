From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 11:52:49 -0600
Subject: [PATCH 2/4] ARM: dt: tegra seaboard: configure I2C2 pinmux
In-Reply-To: <1335462771-21791-1-git-send-email-swarren@wwwdotorg.org>
References: <1335462771-21791-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1335462771-21791-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The I2C2 controller can be routed to either pingroup DDC or PTA. Seaboard
actually uses this as an I2C bus mux, and devices are connected to both
pingroups. This change statically assigns the I2C2 controller to pingroup
PTA, so that on-board devices can be accessed. The DDC pingroup is used
for EDID/DDC accesses which are not yet required, given the absence of
any Tegra graphics support. I2C muxing will be supported later.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-seaboard.dts |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index 96516fb..19db40a 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -100,7 +100,7 @@
 			};
 			hdint {
 				nvidia,pins = "hdint", "lpw0", "lpw2", "lsc1",
-					"lsck", "lsda", "pta";
+					"lsck", "lsda";
 				nvidia,function = "hdmi";
 			};
 			i2cp {
@@ -134,6 +134,10 @@
 				nvidia,pins = "pmc";
 				nvidia,function = "pwr_on";
 			};
+			pta {
+				nvidia,pins = "pta";
+				nvidia,function = "i2c2";
+			};
 			rm {
 				nvidia,pins = "rm";
 				nvidia,function = "i2c1";
-- 
1.7.0.4
