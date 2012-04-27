From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Apr 2012 13:34:39 -0600
Subject: [PATCH] ARM: dt: tegra trimslice: add support for audio
Message-ID: <1335555279-9297-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

* Add node for the audio codec
* Enable Tegra's I2S1 controller and DAS
* Add node for top-level sound complex

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Mark, I can take this one through the Tegra tree.

 arch/arm/boot/dts/tegra-trimslice.dts |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 23ffa9e..0c1a54c 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -251,6 +251,11 @@
 	i2c at 7000c500 {
 		clock-frequency = <400000>;
 
+		codec: codec at 1a {
+			compatible = "ti,tlv320aic23";
+			reg = <0x1a>;
+		};
+
 		rtc at 56 {
 			compatible = "emmicro,em3027";
 			reg = <0x56>;
@@ -261,16 +266,14 @@
 		status = "disable";
 	};
 
-	i2s at 70002800 {
-		status = "disable";
-	};
-
 	i2s at 70002a00 {
 		status = "disable";
 	};
 
-	das at 70000c00 {
-		status = "disable";
+	sound {
+		compatible = "nvidia,tegra-audio-trimslice";
+		nvidia,i2s-controller = <&tegra_i2s1>;
+		nvidia,audio-codec = <&codec>;
 	};
 
 	serial at 70006000 {
-- 
1.7.0.4
