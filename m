From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 5 Jul 2016 17:04:30 +0800
Subject: [PATCH V2 09/10] arm64: dts: tegra: Add NVIDIA Tegra186 P3310 main
 board support
In-Reply-To: <20160705090431.5852-1-josephl@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
Message-ID: <20160705090431.5852-10-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NVIDIA Tegra186 P3310 main board support, which is a chip module
with DRAM, nonvolatile storage, WiFi, ethernet and PMIC chips on it. It
also needs an IO board and hooks on it to represent as an application
platform.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
Changes in V2:
- update according to the binding fix in V2
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
new file mode 100644
index 000000000000..f5238866d321
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -0,0 +1,34 @@
+#include "tegra186.dtsi"
+
+/ {
+	model = "NVIDIA Tegra186 P3310 main Board";
+	compatible = "nvidia,p3301", "nvidia,tegra186";
+
+	aliases {
+		serial0 = &uarta;
+	};
+
+	chosen {
+		bootargs = "earlycon console=ttyS0,115200n8";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x2 0x00000000>;
+	};
+
+	serial at 03100000 {
+		// HACK: before clk driver ready
+		clock-frequency = <408000000>;
+		status = "okay";
+	};
+
+	hsp at 03c00000 {
+		status = "okay";
+	};
+
+	bpmp {
+		status = "okay";
+	};
+};
-- 
2.9.0
