From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 13 May 2016 13:13:04 +0000
Subject: [PATCH-V2 3/5] ARM: bcm2835: add thermal node to device-tree of
 bcm283x
In-Reply-To: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
References: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463145186-12906-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the node for the thermal sensor of the bcm2835-soc
to the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 8aaf193..2b5cbc6 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -153,6 +153,12 @@
 			status = "disabled";
 		};
 
+		thermal: thermal at 0x7e212000 {
+			compatible = "brcm,bcm2835-thermal";
+			reg = <0x7e212000 0x8>;
+			clocks = <&clocks BCM2835_CLOCK_TSENS>;
+		};
+
 		aux: aux at 0x7e215000 {
 			compatible = "brcm,bcm2835-aux";
 			#clock-cells = <1>;
-- 
2.1.4
