From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 1 Oct 2015 17:56:22 +0200
Subject: [PATCH 4/4] ARM: dts: Enable Ethernet on STi's B2199 board
In-Reply-To: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
References: <1443714982-16251-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1443714982-16251-5-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The B2199 board is mounted with Realtek RTL8367 switch.
We consider the bootloader will have intiliazed the switch before jumping into
the kernel, so we declare it as a fixed link.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih418-b2199.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 82eee39..772d2bb 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -24,6 +24,7 @@
 
 	aliases {
 		ttyAS0 = &sbc_serial0;
+		ethernet0 = &ethernet0;
 	};
 
 	soc {
@@ -101,5 +102,12 @@
 		st_dwc3: dwc3 at 8f94000 {
 			status = "okay";
 		};
+
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
