From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Mon, 18 Dec 2017 20:14:42 +0800
Subject: [PATCH v4 13/16] ARM: dts: rockchip: add rx0 mipi-phy for rk3288
In-Reply-To: <20171218121445.6086-1-jacob-chen@iotwrt.com>
References: <20171218121445.6086-1-jacob-chen@iotwrt.com>
Message-ID: <20171218121445.6086-10-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacob Chen <jacob2.chen@rock-chips.com>

It's a Designware MIPI D-PHY, used by ISP in rk3288.

Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ed0b17d1b116..aa9ad3a6e0a5 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -864,6 +864,13 @@
 			status = "disabled";
 		};
 
+		mipi_phy_rx0: mipi-phy-rx0 {
+			compatible = "rockchip,rk3288-mipi-dphy";
+			clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_MIPI_CSI>;
+			clock-names = "dphy-ref", "pclk";
+			status = "disabled";
+		};
+
 		io_domains: io-domains {
 			compatible = "rockchip,rk3288-io-voltage-domain";
 			status = "disabled";
-- 
2.15.1
