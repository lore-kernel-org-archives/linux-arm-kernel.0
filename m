From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 09 Aug 2013 16:40:53 +0900
Subject: [PATCHv2 5/5] ARM: dts: Add dt binding documentation for exynos
 rotator
In-Reply-To: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
References: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1376034053-31910-6-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describes each nodes of rotator and specifies a example how to bind
it.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/gpu/samsung-rotator.txt    |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.txt

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
new file mode 100644
index 0000000..31ee7b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
@@ -0,0 +1,26 @@
+* Samsung Image Rotator
+
+Required properties:
+  - compatible : value should be following:
+	(a) "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
+	(b) "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/4412
+	(c) "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
+
+  - reg : Physical base address of the IP registers and length of memory
+	  mapped region.
+
+  - interrupts : Interrupt number of Rotator
+
+  - clocks : Clock number described in Documentations/devicetree/binding/clock.
+
+  - clock-names : Clock name.
+
+Example:
+	rotator: rotator at 12800000 {
+		compatible = "samsung,exynos4210-rotator";
+		reg = <0x12810000 0x1000>;
+		interrupts = <0 83 0>;
+		clocks = <&clock 278>;
+		clock-names = "rotator";
+		status = "disabled";
+	};
-- 
1.7.9.5
