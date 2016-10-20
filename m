From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 20 Oct 2016 17:21:25 +0200
Subject: [PATCH 3/4] ARM: dts: stm32f429: Fix Ethernet node on Eval Board
In-Reply-To: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
References: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1476976886-23781-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"phy-handle" entry is mandatory when mdio subnode is used in
Ethernet node.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index fa30bf1..a11b108 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -99,7 +99,7 @@
 	pinctrl-0	= <&ethernet_mii>;
 	pinctrl-names	= "default";
 	phy-mode	= "mii";
-
+	phy-handle	= <&phy1>;
 	mdio0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.9.1
