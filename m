From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:57 +0200
Subject: [PATCH 37/41] devicetree: bindings: Renesas APMU and SMP Enable method
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <e454b359b7a0a6f59e3d83394e6d4e598554cb33.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add DT binding documentation for the APMU hardware and add "renesas,apmu"
to the list of enable methods for the ARM cpus.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
 .../devicetree/bindings/power/renesas,apmu.txt     | 31 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,apmu.txt

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 3f0cbbb8395f..fa7520eb6387 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -204,6 +204,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "renesas,apmu"
 			    "rockchip,rk3036-smp"
 			    "rockchip,rk3066-smp"
 			    "ste,dbx500-smp"
diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.txt b/Documentation/devicetree/bindings/power/renesas,apmu.txt
new file mode 100644
index 000000000000..84404c9edff7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.txt
@@ -0,0 +1,31 @@
+DT bindings for the Renesas Advanced Power Management Unit
+
+Renesas R-Car line of SoCs utilize one or more APMU hardware units
+for CPU core power domain control including SMP boot and CPU Hotplug.
+
+Required properties:
+
+- compatible: Should be "renesas,<soctype>-apmu", "renesas,apmu" as fallback.
+	      Examples with soctypes are:
+		- "renesas,r8a7790-apmu" (R-Car H2)
+		- "renesas,r8a7791-apmu" (R-Car M2-W)
+		- "renesas,r8a7792-apmu" (R-Car V2H)
+		- "renesas,r8a7793-apmu" (R-Car M2-N)
+		- "renesas,r8a7794-apmu" (R-Car E2)
+
+- reg: Base address and length of the I/O registers used by the APMU.
+
+- cpus: This node contains a list of CPU cores, which should match the order
+  of CPU cores used by the WUPCR and PSTR registers in the Advanced Power
+  Management Unit section of the device's datasheet.
+
+
+Example:
+
+This shows the r8a7791 APMU that can control CPU0 and CPU1.
+
+	apmu at e6152000 {
+		compatible = "renesas,r8a7791-apmu", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1>;
+	};
-- 
2.7.0.rc3.207.g0ac5344
