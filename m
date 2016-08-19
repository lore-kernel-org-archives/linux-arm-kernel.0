From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:30 +0200
Subject: [PATCH v3 09/12] arm64: dts: tegra: Add NVIDIA P3310 main board
 support
In-Reply-To: <20160819173233.13260-1-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
Message-ID: <20160819173233.13260-10-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

The NVIDIA P3310 is a processor module used in several reference designs
that features a Tegra186 SoC, 8 GiB of LPDDR4 RAM, 32 GiB eMMC and other
essentials such as ethernet, WiFi and a PMIC. It is typically connected
to an I/O board (such as the P2597) that provides the connecters needed
to hook it up to the outside world.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- fix compatible string

 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
new file mode 100644
index 000000000000..dc07ea618378
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -0,0 +1,34 @@
+#include "tegra186.dtsi"
+
+/ {
+	model = "NVIDIA Tegra186 P3310 main Board";
+	compatible = "nvidia,p3310", "nvidia,tegra186";
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
