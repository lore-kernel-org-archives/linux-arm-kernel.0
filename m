From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 22 Sep 2011 15:06:05 -0600
Subject: [PATCH 2/4] arm/dt: Tegra: Add pinmux node to tegra20.dtsi
In-Reply-To: <1316725567-17881-1-git-send-email-swarren@nvidia.com>
References: <1316725567-17881-1-git-send-email-swarren@nvidia.com>
Message-ID: <1316725567-17881-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pinmux node to tegra20.dtsi in order to instantiate the future
pinmux device.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
See patch 0000 for details on dependencies.

 .../devicetree/bindings/pinmux/pinmux_nvidia.txt   |    5 +++++
 arch/arm/boot/dts/tegra20.dtsi                     |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)
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
index 5727595..5921c1d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -77,6 +77,11 @@
 		gpio-controller;
 	};
 
+	pinmux: pinmux at 70000000 {
+		compatible = "nvidia,tegra20-pinmux";
+		reg = < 0x70000000 0xc00 >;
+	};
+
 	serial at 70006000 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
-- 
1.7.0.4
