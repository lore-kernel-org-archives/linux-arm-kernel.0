From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Tue, 21 Mar 2017 16:13:29 +0100
Subject: [PATCH v2 3/5] ARM: dts: stm32: Add CRC support to stm32f746
In-Reply-To: <1490109211-4869-1-git-send-email-fabien.dessenne@st.com>
References: <1490109211-4869-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <1490109211-4869-4-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CRC (CRC32 crypto) support to stm32f746.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index f321ffe..755fb92 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -289,6 +289,13 @@
 			};
 		};
 
+		crc: crc at 40023000 {
+			compatible = "st,stm32f7-crc";
+			reg = <0x40023000 0x400>;
+			clocks = <&rcc 0 12>;
+			status = "disabled";
+		};
+
 		rcc: rcc at 40023800 {
 			#clock-cells = <2>;
 			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
-- 
2.7.4
