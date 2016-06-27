From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 27 Jun 2016 17:02:47 +0800
Subject: [PATCH 09/10] arm64: dts: tegra: Add NVIDIA Tegra186 P3310 main board
 support
In-Reply-To: <20160627090248.23621-1-josephl@nvidia.com>
References: <20160627090248.23621-1-josephl@nvidia.com>
Message-ID: <20160627090248.23621-10-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NVIDIA Tegra186 P3310 main board support, which is a chip module
with DRAM, nonvolatile storage, WiFi, ethernet and PMIC chips on it. It
also needs an IO board and hooks on it to represent as an application
platform.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
new file mode 100644
index 000000000000..5258ec0d6eef
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -0,0 +1,30 @@
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
+	bpmp at d0000000 {
+		status = "okay";
+	};
+};
-- 
2.9.0
