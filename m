From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:31 +0200
Subject: [PATCH v3 10/12] arm64: dts: tegra: Add NVIDIA P2771 board support
In-Reply-To: <20160819173233.13260-1-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
Message-ID: <20160819173233.13260-11-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

Add NVIDIA P2771 is composed of a P3310 processor module that connects
to the P2597 I/O board. It comes with a 1200x1920 MIPI DSI panel
connected via the P2597's display connector and has several connectors
such as HDMI, USB 3.0, PCIe and ethernet.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/Makefile                | 1 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts

diff --git a/arch/arm64/boot/dts/nvidia/Makefile b/arch/arm64/boot/dts/nvidia/Makefile
index 0f7cdf3e05c1..67234f3dc795 100644
--- a/arch/arm64/boot/dts/nvidia/Makefile
+++ b/arch/arm64/boot/dts/nvidia/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_TEGRA_132_SOC) += tegra132-norrin.dtb
+dtb-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-p2771-0000.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-0000.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-2180.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2571.dtb
diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
new file mode 100644
index 000000000000..66b936389fa7
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -0,0 +1,8 @@
+/dts-v1/;
+
+#include "tegra186-p3310.dtsi"
+
+/ {
+	model = "NVIDIA Tegra186 P2771-0000 Board";
+	compatible = "nvidia,p2771-0000", "nvidia,tegra186";
+};
-- 
2.9.0
