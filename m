From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Nov 2016 18:11:29 +0100
Subject: [PATCH 7/9] arm64: tegra: Add NVIDIA P3310 processor module support
In-Reply-To: <20161117171131.20062-1-thierry.reding@gmail.com>
References: <20161117171131.20062-1-thierry.reding@gmail.com>
Message-ID: <20161117171131.20062-7-thierry.reding@gmail.com>
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
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
new file mode 100644
index 000000000000..807af7b68761
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -0,0 +1,32 @@
+#include "tegra186.dtsi"
+
+/ {
+	model = "NVIDIA Tegra186 P3310 Processor Module";
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
+	serial at 3100000 {
+		status = "okay";
+	};
+
+	hsp at 3c00000 {
+		status = "okay";
+	};
+
+	bpmp {
+		status = "okay";
+	};
+};
-- 
2.10.2
