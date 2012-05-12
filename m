From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:37:55 -0600
Subject: [PATCH 3/9] ARM: dt: tegra: gpio comment cleanup
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1336783081-16978-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Ensure that all Tegraa GPIO specifiers contain a comment indicating which
GPIO name the number refers to.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-paz00.dts     |    4 ++--
 arch/arm/boot/dts/tegra-trimslice.dts |    4 ++--
 arch/arm/boot/dts/tegra-ventana.dts   |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 4983ef1..03b2e65 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -252,7 +252,7 @@
 		reg = <0x7000C500 0x100>;
 		interrupts = <0 92 0x04>;
 		clock-frequency = <80000>;
-		request-gpios = <&gpio 170 0>;
+		request-gpios = <&gpio 170 0>; /* gpio PV2 */
 		slave-addr = <138>;
 	};
 
@@ -343,7 +343,7 @@
 
 		wifi {
 			label = "wifi-led";
-			gpios = <&gpio 24 0>;
+			gpios = <&gpio 24 0>; /* gpio PD0 */
 			linux,default-trigger = "rfkill0";
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 4436b42..eebcf50 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -305,8 +305,8 @@
 	};
 
 	sdhci at c8000600 {
-		cd-gpios = <&gpio 121 0>;
-		wp-gpios = <&gpio 122 0>;
+		cd-gpios = <&gpio 121 0>; /* gpio PP1 */
+		wp-gpios = <&gpio 122 0>; /* gpio PP2 */
 	};
 
 	usb at c5004000 {
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 0c8d30d..e64318d 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -302,7 +302,7 @@
 
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
-		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
+		nvidia,int-mic-en-gpios = <&gpio 184 0>; /* gpio PX0 */
 		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
 	};
 
-- 
1.7.0.4
