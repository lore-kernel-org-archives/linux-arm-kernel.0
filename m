From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 20 Jul 2016 15:28:30 +0930
Subject: [PATCH 09/12] palmetto: Request relevant mux functions in devicetree
In-Reply-To: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
Message-ID: <1468994313-13538-10-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The requested functions are parented by the pinctrl node to provide the
Palmetto's static pin configuration.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index cc5fcf2940bf..d8d05ee4956b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -20,6 +20,34 @@
 	};
 };
 
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flbusy_default &pinctrl_flwp_default
+			&pinctrl_vgahs_default &pinctrl_vgavs_default
+			&pinctrl_ddcclk_default &pinctrl_ddcdat_default
+			&pinctrl_pwm0_default &pinctrl_pwm1_default
+			&pinctrl_pwm2_default &pinctrl_pwm3_default
+			&pinctrl_pwm4_default &pinctrl_pwm5_default
+			&pinctrl_pwm6_default &pinctrl_pwm7_default
+			&pinctrl_bmcint_default &pinctrl_flack_default
+			&pinctrl_rom8_default>;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ncts1_default &pinctrl_ndcd1_default
+			&pinctrl_nri1_default &pinctrl_ndtr1_default
+			&pinctrl_nrts1_default &pinctrl_txd1_default
+			&pinctrl_rxd1_default>;
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ncts4_default &pinctrl_ndcd4_default
+			&pinctrl_nri4_default &pinctrl_txd4_default
+			&pinctrl_rxd4_default>;
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.7.4
