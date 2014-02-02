From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Feb 2014 12:08:40 +0400
Subject: [PATCH v2 RESEND 2/3] ARM: dts: clps711x: Add bindings documentation
 for CLPS711X irqchip driver
Message-ID: <1391328520-30923-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OF document for Cirrus Logic CLPS711X irqchip driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../interrupt-controller/cirrus,clps711x-intc.txt  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
new file mode 100644
index 0000000..759339c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
@@ -0,0 +1,41 @@
+Cirrus Logic CLPS711X Interrupt Controller
+
+Required properties:
+
+- compatible: Should be "cirrus,clps711x-intc".
+- reg: Specifies base physical address of the registers set.
+- interrupt-controller: Identifies the node as an interrupt controller.
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+
+The interrupt sources are as follows:
+ID	Name	Description
+---------------------------
+1:	BLINT	Battery low (FIQ)
+3:	MCINT	Media changed (FIQ)
+4:	CSINT	CODEC sound
+5:	EINT1	External 1
+6:	EINT2	External 2
+7:	EINT3	External 3
+8:	TC1OI	TC1 under flow
+9:	TC2OI	TC2 under flow
+10:	RTCMI	RTC compare match
+11:	TINT	64Hz tick
+12:	UTXINT1	UART1 transmit FIFO half empty
+13:	URXINT1	UART1 receive FIFO half full
+14:	UMSINT	UART1 modem status changed
+15:	SSEOTI	SSI1 end of transfer
+16:	KBDINT	Keyboard
+17:	SS2RX	SSI2 receive FIFO half or greater full
+18:	SS2TX	SSI2 transmit FIFO less than half empty
+28:	UTXINT2	UART2 transmit FIFO half empty
+29:	URXINT2	UART2 receive FIFO half full
+32:	DAIINT	DAI interface (FIQ)
+
+Example:
+	intc: interrupt-controller {
+		compatible = "cirrus,clps711x-intc";
+		reg = <0x80000000 0x4000>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
-- 
1.8.3.2
