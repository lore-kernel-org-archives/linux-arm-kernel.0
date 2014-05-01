From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu,  1 May 2014 16:14:45 +0530
Subject: [PATCH 2/2] Documentation: DT: Exynos: Bind SRAM though DT
In-Reply-To: <1398941085-10224-1-git-send-email-sachin.kamat@linaro.org>
References: <1398941085-10224-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1398941085-10224-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SRAM binding documentation.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 .../devicetree/bindings/arm/exynos/smp-sram.txt    |   38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/smp-sram.txt

diff --git a/Documentation/devicetree/bindings/arm/exynos/smp-sram.txt b/Documentation/devicetree/bindings/arm/exynos/smp-sram.txt
new file mode 100644
index 000000000000..9969ca22b6af
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/exynos/smp-sram.txt
@@ -0,0 +1,38 @@
+Samsung Exynos SRAM for SMP bringup:
+------------------------------------
+
+Samsung SMP-capable Exynos SoCs use part of the SRAM for the bringup
+of the cores. Once the core gets powered up it executes the code
+that is residing at some specific location of the SRAM.
+
+Therefore reserved section sub-nodes have to be added to the mmio-sram
+declaration. These nodes are of two types depending upon secure or
+non-secure execution environment.
+
+Required sub-node properties:
+- compatible : should be
+		"samsung,exynos4210-sram" : Secure SYSRAM
+		"samsung,exynos4210-sram-ns" : Non-secure SYSRAM
+
+The rest of the properties should follow the generic mmio-sram discription
+found in ../../misc/sram.txt
+
+Example:
+
+	sram at 02020000 {
+		compatible = "mmio-sram";
+		reg = <0x02020000 0x54000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x02020000 0x54000>;
+
+		smp-sram at 0 {
+			compatible = "samsung,exynos4210-sram";
+			reg = <0x0 0x1000>;
+		};
+
+		smp-sram at 53000 {
+			compatible = "samsung,exynos4210-sram-ns";
+			reg = <0x53000 0x1000>;
+		};
+	};
-- 
1.7.9.5
