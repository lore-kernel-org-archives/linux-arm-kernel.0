From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Fri, 29 Dec 2017 15:52:55 +0800
Subject: [PATCH v5 13/16] ARM: dts: rockchip: add rx0 mipi-phy for rk3288
In-Reply-To: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1514533978-20408-14-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacob Chen <jacob2.chen@rock-chips.com>

It's a Designware MIPI D-PHY, used by ISP in rk3288.

Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5dbfafb..a4c9a6e 100644
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
1.9.1
