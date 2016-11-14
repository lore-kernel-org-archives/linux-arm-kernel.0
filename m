From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 14 Nov 2016 18:32:03 +0100
Subject: [PATCH 1/2] ARM: dts: da850: add the mstpri and ddrctl nodes
In-Reply-To: <1479144724-14231-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479144724-14231-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479144724-14231-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the nodes for the MSTPRI configuration and DDR2/mDDR memory
controller drivers to da850.dtsi.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 1bb1f6d..1635218 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -440,6 +440,11 @@
 			interrupts = <52>;
 			status = "disabled";
 		};
+
+		mstpri: mstpri at 14110 {
+			compatible = "ti,da850-mstpri";
+			reg = <0x14110 0x0c>;
+		};
 	};
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
@@ -451,4 +456,8 @@
 			  1 0 0x68000000 0x00008000>;
 		status = "disabled";
 	};
+	ddrctl: ddrctl at b0000000 {
+		compatible = "ti,da850-ddr-controller";
+		reg = <0xb0000000 0xe8>;
+	};
 };
-- 
2.9.3
