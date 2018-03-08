From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Thu,  8 Mar 2018 17:48:04 +0800
Subject: [PATCH v6 14/17] ARM: dts: rockchip: Add dts mipi-dphy TXRX1 node for
 rk3288
In-Reply-To: <20180308094807.9443-1-jacob-chen@iotwrt.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
Message-ID: <20180308094807.9443-15-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wen Nuan <leo.wen@rock-chips.com>

Change-Id: I0b6122b2b34ae0f24f0d4a1111c1bbe6018cac4e
Signed-off-by: Wen Nuan <leo.wen@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 3a530b72c057..ed05f3d77358 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1164,6 +1164,15 @@
 		};
 	};
 
+	mipi_phy_tx1rx1: mipi-phy-tx1rx1 at ff968000 {
+		compatible = "rockchip,rk3288-mipi-dphy";
+		reg = <0x0 0xff968000 0x0 0x4000>;
+		rockchip,grf = <&grf>;
+		clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_MIPI_CSI>;
+		clock-names = "dphy-ref", "pclk";
+		status = "disabled";
+	};
+
 	edp: dp at ff970000 {
 		compatible = "rockchip,rk3288-dp";
 		reg = <0x0 0xff970000 0x0 0x4000>;
-- 
2.16.1
