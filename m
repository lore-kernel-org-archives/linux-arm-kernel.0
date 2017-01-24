From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Jan 2017 13:43:10 +0000
Subject: [PATCH 8/8] ARM: dts: STiH407-family: Enable HW flow-control
In-Reply-To: <20170124134310.27512-1-lee.jones@linaro.org>
References: <20170124134310.27512-1-lee.jones@linaro.org>
Message-ID: <20170124134310.27512-9-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware flow-control capability must be specified at a platform
level in order to inform the ASC driver that the platform is capable
(i.e. are the lines wired up, etc).  STiH4{07,10} devices are indeed
capable, so let's provide the property.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 9789978..7ada8ea 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -226,7 +226,7 @@
 			pinctrl-0 = <&pinctrl_serial0_flowctrl>;
 			pinctrl-1 = <&pinctrl_serial0>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
-
+			st,hw-flow-control;
 			status = "disabled";
 		};
 
-- 
2.10.2
