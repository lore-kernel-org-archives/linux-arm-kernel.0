From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Sep 2015 14:45:56 +0100
Subject: [PATCH v2 6/7] ARM: STi: STiH407: Enable the 2 HW Random Number
 Generators for STiH4{07, 10}
In-Reply-To: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1442497557-9271-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 838b812..9452b42 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -565,5 +565,19 @@
 						  <&phy_port2 PHY_TYPE_USB3>;
 			};
 		};
+
+		rng10: rng at 08a89000 {
+			compatible      = "st,rng";
+			reg		= <0x08a89000 0x1000>;
+			clocks          = <&clk_sysin>;
+			status		= "okay";
+		};
+
+		rng11: rng at 08a8a000 {
+			compatible      = "st,rng";
+			reg		= <0x08a8a000 0x1000>;
+			clocks          = <&clk_sysin>;
+			status		= "okay";
+		};
 	};
 };
-- 
1.9.1
