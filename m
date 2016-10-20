From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 20 Oct 2016 17:21:24 +0200
Subject: [PATCH 2/4] ARM: dts: stm32f429: Update Ethernet node on Eval board
In-Reply-To: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
References: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1476976886-23781-3-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update new pinctrl phandle name and use new node name.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 13c7cd2..fa30bf1 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -94,11 +94,12 @@
 	clock-frequency = <25000000>;
 };
 
-&ethernet0 {
+&mac {
 	status = "okay";
-	pinctrl-0	= <&ethernet0_mii>;
+	pinctrl-0	= <&ethernet_mii>;
 	pinctrl-names	= "default";
-	phy-mode	= "mii-id";
+	phy-mode	= "mii";
+
 	mdio0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.9.1
