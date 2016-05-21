From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 May 2016 23:23:48 +0200
Subject: [PATCH 3/3] arm64: dts: rockchip: add rk3399 io-domain core nodes
In-Reply-To: <1463865828-14583-1-git-send-email-heiko@sntech.de>
References: <1463865828-14583-1-git-send-email-heiko@sntech.de>
Message-ID: <1463865828-14583-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the core io-domain nodes to grf and pmugrf which individual
boards than just have to enable and add the necessary supplies to.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a6a60fa..12acae6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -407,6 +407,11 @@
 		reg = <0x0 0xff320000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
+
+		pmu_io_domains: io-domains {
+			compatible = "rockchip,rk3399-pmu-io-voltage-domain";
+			status = "disabled";
+		};
 	};
 
 	spi3: spi at ff350000 {
@@ -517,6 +522,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		io_domains: io-domains {
+			compatible = "rockchip,rk3399-io-voltage-domain";
+			status = "disabled";
+		};
+
 		emmc_phy: phy at f780 {
 			compatible = "rockchip,rk3399-emmc-phy";
 			reg = <0xf780 0x24>;
-- 
2.6.4
