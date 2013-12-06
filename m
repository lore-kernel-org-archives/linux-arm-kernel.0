From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  6 Dec 2013 16:55:28 -0700
Subject: [PATCH V2] ARM: tegra: add Tegra124 pinmux node to DT
Message-ID: <1386374128-5209-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Tested-by: Thierry Reding <treding@nvidia.com>
---
v2: Fix register lengths to match the values from Laxman's patch
---
 arch/arm/boot/dts/tegra124.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 9a8b5b8d8397..fe070bc4c862 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -97,6 +97,12 @@
 		#dma-cells = <1>;
 	};
 
+	pinmux: pinmux at 70000868 {
+		compatible = "nvidia,tegra124-pinmux";
+		reg = <0x70000868 0x164>,	/* Pad control registers */
+		      <0x70003000 0x434>;	/* Mux registers */
+	};
+
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
-- 
1.8.1.5
