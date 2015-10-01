From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 1 Oct 2015 17:56:21 +0200
Subject: [PATCH 3/4] ARM: dts: Enable Ethernet on STi's B2120 boards
In-Reply-To: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
References: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1443714982-16251-4-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These boards are mounted with Realtek RTL8367 switch.
We consider the bootloader will have intiliazed the switch before jumping into
the kernel, so we declare it as a fixed link.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih407-b2120.dts  | 1 +
 arch/arm/boot/dts/stih410-b2120.dts  | 1 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index 6d93475..c8ad905 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -25,6 +25,7 @@
 
 	aliases {
 		ttyAS0 = &sbc_serial0;
+		ethernet0 = &ethernet0;
 	};
 
 };
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 8af1e73..118ac28 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -25,6 +25,7 @@
 
 	aliases {
 		ttyAS0 = &sbc_serial0;
+		ethernet0 = &ethernet0;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index ab029f7..ad21a42 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -87,5 +87,11 @@
 			status = "okay";
 		};
 
+		ethernet0: dwmac at 9630000 {
+			st,tx-retime-src = "clkgen";
+			status = "okay";
+			phy-mode = "rgmii";
+			fixed-link = <0 1 1000 0 0>;
+		};
 	};
 };
-- 
1.9.1
