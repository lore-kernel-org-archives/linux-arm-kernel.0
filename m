From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 11 Sep 2015 18:06:28 +0100
Subject: [PATCH 05/11] ARM: DT: STiH407: Add SPI FSM (NOR Flash) Controller
 pin config
In-Reply-To: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1441991194-11948-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the pin configuration for the NOR flash controller.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 6c81f35..d0f5fdd 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -872,6 +872,19 @@
 					};
 				};
 			};
+
+			fsm {
+				pinctrl_fsm: fsm {
+					st,pins {
+						spi-fsm-clk = <&pio40 1 ALT1 OUT>;
+						spi-fsm-cs = <&pio40 0 ALT1 OUT>;
+						spi-fsm-mosi = <&pio40 2 ALT1 OUT>;
+						spi-fsm-miso = <&pio40 3 ALT1 IN>;
+						spi-fsm-hol = <&pio40 5 ALT1 OUT>;
+						spi-fsm-wp = <&pio40 4 ALT1 OUT>;
+					};
+				};
+			};
 		};
 	};
 };
-- 
1.9.1
