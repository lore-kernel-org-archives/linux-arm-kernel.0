From: a.heider@gmail.com (Andre Heider)
Date: Sun, 29 Jun 2014 18:21:46 +0200
Subject: [PATCH 12/13] ARM: dts: am33xx: add the PRUSSv2 device
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Message-ID: <1404058907-21112-13-git-send-email-a.heider@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..28a7e5d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -409,6 +409,15 @@
 			ti,hwmods = "rtc";
 		};
 
+		pruss: pruss at 4a300000 {
+			compatible = "ti,pruss-v2";
+			ti,hwmods = "pruss";
+			reg = <0x4a300000 0x080000>;
+			interrupts = <20 21 22 23 24 25 26 27>;
+			interrupt-parent = <&intc>;
+			status = "disabled";
+		};
+
 		spi0: spi at 48030000 {
 			compatible = "ti,omap4-mcspi";
 			#address-cells = <1>;
-- 
2.0.0
