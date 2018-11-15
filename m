From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 15 Nov 2018 08:52:29 +0000
Subject: [PATCH 1/3] ARM: dts: stm32: change CAN RAM mapping on stm32mp157c
In-Reply-To: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
References: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
Message-ID: <1542271942-28130-2-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split the 10Kbytes CAN message RAM to be able to use simultaneously
FDCAN1 and FDCAN2 instances.
First 5Kbytes are allocated to FDCAN1 and last 5Kbytes are used for
FDCAN2. To do so, set the offset to 0x1400 in mram-cfg for FDCAN2.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 8bf1c17..ffd7457 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -684,7 +684,7 @@
 
 		m_can1: can at 4400e000 {
 			compatible = "bosch,m_can";
-			reg = <0x4400e000 0x400>, <0x44011000 0x2800>;
+			reg = <0x4400e000 0x400>, <0x44011000 0x1400>;
 			reg-names = "m_can", "message_ram";
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
@@ -704,7 +704,7 @@
 			interrupt-names = "int0", "int1";
 			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
 			clock-names = "hclk", "cclk";
-			bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
+			bosch,mram-cfg = <0x1400 0 0 32 0 0 2 2>;
 			status = "disabled";
 		};
 
-- 
1.9.1
