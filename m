From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 11 Oct 2011 16:16:13 -0600
Subject: [PATCH v4 2/4] arm/dt: Tegra: Add pinmux node to tegra20.dtsi
In-Reply-To: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
Message-ID: <1318371375-4083-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pinmux node to tegra20.dtsi in order to instantiate the future
pinmux device.

v2: Specify reg property precisely; don't just point at the whole APB_MISC
register range.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../devicetree/bindings/pinmux/pinmux_nvidia.txt   |    5 +++++
 arch/arm/boot/dts/tegra20.dtsi                     |    8 ++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt

diff --git a/Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt b/Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt
new file mode 100644
index 0000000..36f82db
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt
@@ -0,0 +1,5 @@
+NVIDIA Tegra 2 pinmux controller
+
+Required properties:
+- compatible : "nvidia,tegra20-pinmux"
+
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 5727595..65d7e6a 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -77,6 +77,14 @@
 		gpio-controller;
 	};
 
+	pinmux: pinmux at 70000000 {
+		compatible = "nvidia,tegra20-pinmux";
+		reg = < 0x70000014 0x10    /* Tri-state registers */
+			0x70000080 0x20    /* Mux registers */
+			0x700000a0 0x14    /* Pull-up/down registers */
+			0x70000868 0xa8 >; /* Pad control registers */
+	};
+
 	serial at 70006000 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
-- 
1.7.0.4
