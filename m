From: beagleboard@davidjohnsummers.uk (David Summers)
Date: Sat, 22 Sep 2018 18:02:35 +0100
Subject: [PATCH 2/3] This patch add the eMMC to the ASUS tinker board S
In-Reply-To: <20180922170236.8690-1-beagleboard@davidjohnsummers.uk>
References: <20180922170236.8690-1-beagleboard@davidjohnsummers.uk>
Message-ID: <20180922170236.8690-3-beagleboard@davidjohnsummers.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 arch/arm/boot/dts/rk3288-tinker-s.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker-s.dts b/arch/arm/boot/dts/rk3288-tinker-s.dts
index 5e1078c6a784..bc691e3f9c07 100644
--- a/arch/arm/boot/dts/rk3288-tinker-s.dts
+++ b/arch/arm/boot/dts/rk3288-tinker-s.dts
@@ -11,3 +11,17 @@
 	model = "Rockchip RK3288 Asus Tinker Board S";
 	compatible = "asus,rk3288-tinker-s", "rockchip,rk3288";
 };
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
+	max-frequency = <150000000>;
+	mmc-hs200-1_8v;
+	mmc-ddr-1_8v;
+	status = "okay";
+};
-- 
David Summers <beagleboard@davididjohnsummers.uk>
