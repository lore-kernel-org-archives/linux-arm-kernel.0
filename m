From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue, 13 May 2014 13:57:33 +0200
Subject: [PATCH 2/2] drivers: clk: st: authorize propagate rate change for
 clockgenD0
In-Reply-To: <1399982253-21079-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1399982253-21079-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1399982253-21079-3-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the spread of change rate only for clockgenD0
clocks.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 1 +
 drivers/clk/st/clk-flexgen.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 5f1c83c..7fad261 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -204,6 +204,7 @@
 					"CLK_PCM_1",
 					"CLK_PCM_2",
 					"CLK_SPDIFF";
+				set-rate-parent;
 			};
 		};
 
diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index f3ed700..5629988 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -306,6 +306,8 @@ void __init st_of_flexgen_setup(struct device_node *np)
 		if (*clk_name == '\0')
 			continue;
 
+		flex_flags = of_clk_get_flags(np);
+
 		clk = clk_register_flexgen(clk_name, parents, num_parents,
 					   reg, rlock, i, flex_flags);
 
-- 
1.9.1
