From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 19 Aug 2016 22:17:02 +0930
Subject: [PATCH v2 4/7] palmetto: Request relevant mux functions in devicetree
In-Reply-To: <20160819124705.24633-1-andrew@aj.id.au>
References: <20160819124705.24633-1-andrew@aj.id.au>
Message-ID: <20160819124705.24633-5-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The requested functions are parented by the pinctrl node to provide the
Palmetto's static pin configuration.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

Since v1:

* Remove some unnecessary mux requests

 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index cc5fcf2940bf..648fb6b9e427 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -20,6 +20,20 @@
 	};
 };
 
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flbusy_default &pinctrl_flwp_default
+			&pinctrl_vgahs_default &pinctrl_vgavs_default
+			&pinctrl_ddcclk_default &pinctrl_ddcdat_default
+
+			&pinctrl_pwm1_default &pinctrl_pwm2_default
+			&pinctrl_pwm3_default &pinctrl_pwm4_default
+			&pinctrl_pwm5_default &pinctrl_pwm6_default
+			&pinctrl_pwm7_default
+
+			&pinctrl_bmcint_default &pinctrl_flack_default>;
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.9.3
