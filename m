From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Nov 2016 18:11:31 +0100
Subject: [PATCH 9/9] arm64: tegra: Add NVIDIA P2771 board support
In-Reply-To: <20161117171131.20062-1-thierry.reding@gmail.com>
References: <20161117171131.20062-1-thierry.reding@gmail.com>
Message-ID: <20161117171131.20062-9-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

The NVIDIA P2771 is composed of a P3310 processor module that connects
to the P2597 I/O board. It comes with a 1200x1920 MIPI DSI panel that is
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
index 0f7cdf3e05c1..18941458cb4d 100644
--- a/arch/arm64/boot/dts/nvidia/Makefile
+++ b/arch/arm64/boot/dts/nvidia/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-0000.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-2180.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2571.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-smaug.dtb
+dtb-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-p2771-0000.dtb
 
 always		:= $(dtb-y)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
new file mode 100644
index 000000000000..0d3c0996d832
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -0,0 +1,8 @@
+/dts-v1/;
+
+#include "tegra186-p3310.dtsi"
+
+/ {
+	model = "NVIDIA Tegra186 P2771-0000 Development Board";
+	compatible = "nvidia,p2771-0000", "nvidia,tegra186";
+};
-- 
2.10.2
