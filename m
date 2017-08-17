From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 17 Aug 2017 21:54:10 +0300
Subject: [PATCH 3/6] arm64: tegra: Add VIC on Tegra186
In-Reply-To: <20170817185413.6324-1-mperttunen@nvidia.com>
References: <20170817185413.6324-1-mperttunen@nvidia.com>
Message-ID: <20170817185413.6324-4-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Video Image Compositor on the Tegra186.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 3556f89ddf1d..477d733f23eb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -371,6 +371,18 @@
 		#size-cells = <2>;
 
 		ranges = <0x0 0x15000000 0x0 0x15000000 0x0 0x01000000>;
+
+		vic at 15340000 {
+			compatible = "nvidia,tegra186-vic";
+			reg = <0x0 0x15340000 0x0 0x40000>;
+			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA186_CLK_VIC>;
+			clock-names = "vic";
+			resets = <&bpmp TEGRA186_RESET_VIC>;
+			reset-names = "vic";
+
+			power-domains = <&bpmp TEGRA186_POWER_DOMAIN_VIC>;
+		};
 	};
 
 	gpu at 17000000 {
-- 
2.14.1
