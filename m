From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  4 May 2015 14:27:05 +0200
Subject: [PATCH v2 6/7] ARM: marvell/dt: add crypto node to armada 370 SoC
In-Reply-To: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1430742426-21202-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnaud Ebalard <arno@natisbad.org>

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 27397f1..a04f5aa 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -306,6 +306,28 @@
 					dmacap,memset;
 				};
 			};
+
+			crypto at 90000 {
+				compatible = "marvell,armada-370-crypto";
+				reg = <0x90000 0x10000>;
+				reg-names = "regs";
+				interrupts = <48>;
+				clocks = <&gateclk 23>;
+				clock-names = "cesa0";
+				marvell,crypto-srams = <&crypto_sram>;
+				marvell,crypto-sram-size = <0x800>;
+				status = "okay";
+			};
+		};
+
+		crypto_sram: sa-sram {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x09, 0x01) 0 0x800>;
+			reg-names = "sram";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x09, 0x01) 0 0x800>;
+			status = "okay";
 		};
 	};
 };
-- 
1.9.1
