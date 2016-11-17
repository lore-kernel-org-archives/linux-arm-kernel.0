From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Nov 2016 18:11:24 +0100
Subject: [PATCH 2/9] arm64: tegra: Add CPU nodes for Tegra186
In-Reply-To: <20161117171131.20062-1-thierry.reding@gmail.com>
References: <20161117171131.20062-1-thierry.reding@gmail.com>
Message-ID: <20161117171131.20062-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Tegra186 has six CPUs: two CPUs are second generation Denver CPUs that
support ARMv8 and four CPUs are Cortex-A57 CPUs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 6cb8ac918530..eadbfacd16c2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -57,6 +57,47 @@
 		};
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "nvidia,tegra186-denver", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x000>;
+		};
+
+		cpu at 1 {
+			compatible = "nvidia,tegra186-denver", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x001>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x100>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x101>;
+		};
+
+		cpu at 4 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x102>;
+		};
+
+		cpu at 5 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x103>;
+		};
+	};
+
 	bpmp: bpmp {
 		compatible = "nvidia,tegra186-bpmp";
 		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB
-- 
2.10.2
