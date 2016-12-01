From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  1 Dec 2016 21:09:29 +0100
Subject: [PATCH v2 6/7] ARM: bcm/dt: Add VEC node in bcm283x.dtsi
In-Reply-To: <1480622970-8714-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480622970-8714-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1480622970-8714-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the VEC (Video EnCoder) node definition in bcm283x.dtsi.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/bcm283x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 46d46d894a44..44a9c0539437 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -266,6 +266,14 @@
 			status = "disabled";
 		};
 
+		vec: vec at 7e806000 {
+			compatible = "brcm,bcm2835-vec";
+			reg = <0x7e806000 0x1000>;
+			clocks = <&clocks BCM2835_CLOCK_VEC>;
+			interrupts = <2 27>;
+			status = "disabled";
+		};
+
 		pixelvalve at 7e807000 {
 			compatible = "brcm,bcm2835-pixelvalve2";
 			reg = <0x7e807000 0x100>;
-- 
2.7.4
