From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 31 Oct 2016 15:45:36 +0100
Subject: [PATCH v2 3/5] ARM: dts: da850: add the mstpri and ddrctl nodes
In-Reply-To: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1477925138-23457-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the nodes for the MSTPRI configuration and DDR2/mDDR memory
controller drivers to da850.dtsi.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 112c6d7..44bece3 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -454,6 +454,12 @@
 			interrupts = <52>;
 			status = "disabled";
 		};
+
+		mstpri: mstpri at 14110 {
+			compatible = "ti,da850-mstpri";
+			reg = <0x14110 0x0c>;
+			status = "disabled";
+		};
 	};
 	aemif: aemif at 68000000 {
 		compatible = "ti,da850-aemif";
@@ -465,4 +471,9 @@
 			  1 0 0x68000000 0x00008000>;
 		status = "disabled";
 	};
+	ddrctl: ddrctl at b0000000 {
+		compatible = "ti,da850-ddr-controller";
+		reg = <0xb0000000 0xe8>;
+		status = "disabled";
+	};
 };
-- 
2.9.3
