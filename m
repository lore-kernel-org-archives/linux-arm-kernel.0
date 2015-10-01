From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 1 Oct 2015 17:56:19 +0200
Subject: [PATCH 1/4] ARM: dts: Fix RGMII pinctrl timings
In-Reply-To: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
References: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1443714982-16251-2-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These new re-timing values provides a better stability on Ethernet link.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 8fe542a..a538ae5 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -216,9 +216,9 @@
 						rxd2 = <&pio1 6 ALT1 IN DE_IO 0 CLK_A>;
 						rxd3 = <&pio1 7 ALT1 IN DE_IO 0 CLK_A>;
 						rxdv = <&pio2 0 ALT1 IN DE_IO 0 CLK_A>;
-						rxclk = <&pio2 2 ALT1 IN NICLK 500 CLK_A>;
+						rxclk = <&pio2 2 ALT1 IN NICLK 0 CLK_A>;
 						clk125 = <&pio3 7 ALT4 IN NICLK 0 CLK_A>;
-						phyclk = <&pio2 3 ALT4 OUT NICLK 1750 CLK_B>;
+						phyclk = <&pio2 3 ALT4 OUT NICLK 1250 CLK_B>;
 					};
 				};
 
-- 
1.9.1
