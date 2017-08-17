From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 17 Aug 2017 21:54:09 +0300
Subject: [PATCH 2/6] arm64: tegra: Add host1x on Tegra186
In-Reply-To: <20170817185413.6324-1-mperttunen@nvidia.com>
References: <20170817185413.6324-1-mperttunen@nvidia.com>
Message-ID: <20170817185413.6324-3-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the node for Host1x on the Tegra186, without any subdevices
for now.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index a964d246c0e9..3556f89ddf1d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -355,6 +355,24 @@
 		nvidia,bpmp = <&bpmp>;
 	};
 
+	host1x at 13e00000 {
+		compatible = "nvidia,tegra186-host1x", "simple-bus";
+		reg = <0x0 0x13e00000 0x0 0x10000>,
+		      <0x0 0x13e10000 0x0 0x10000>;
+		reg-names = "hypervisor", "vm";
+		interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_HOST1X>;
+		clock-names = "host1x";
+		resets = <&bpmp TEGRA186_RESET_HOST1X>;
+		reset-names = "host1x";
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x0 0x15000000 0x0 0x15000000 0x0 0x01000000>;
+	};
+
 	gpu at 17000000 {
 		compatible = "nvidia,gp10b";
 		reg = <0x0 0x17000000 0x0 0x1000000>,
-- 
2.14.1
