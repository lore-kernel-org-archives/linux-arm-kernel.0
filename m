From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Dec 2014 11:59:19 +0000
Subject: [PATCH v3 12/13] ARM: STi: stih416: Use new platform specific
 compatible string
In-Reply-To: <1418644760-18773-1-git-send-email-lee.jones@linaro.org>
References: <1418644760-18773-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1418644760-18773-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FSM SPI NOR driver now obtains syscfg particulars using DT match. In
order for this to happen each platform is required to supply their own
specific compatible string.

We're also remove the old, now unused vendor properties from the node.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 84758d7..dec546e 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -214,13 +214,11 @@
 
 		/* FSM */
 		spifsm: spifsm at fe902000 {
-			compatible	   = "st,spi-fsm";
+			compatible	   = "st,stih416-spi-fsm";
 			reg		   = <0xfe902000 0x1000>;
 			pinctrl-0	   = <&pinctrl_fsm>;
 
 			st,syscfg	   = <&syscfg_rear>;
-			st,boot-device-reg = <0x958>;
-			st,boot-device-spi = <0x1a>;
 
 			status = "disabled";
 		};
-- 
1.9.1
