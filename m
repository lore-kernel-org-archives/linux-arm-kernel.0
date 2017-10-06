From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Fri,  6 Oct 2017 12:13:44 +0200
Subject: [PATCH 16/16] arm64: dts: marvell: armada-3720-espressobin: fill UART
 nodes
In-Reply-To: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
Message-ID: <20171006101344.15590-17-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fill ESPRESSObin uart0 node with pinctrl information like in the
Armada-3720-DB device tree (which uses the same node).

Also explain how to enable the second UART port available on the
headers. This second port is not enabled by default because both
headers are dedicated to expose general purpose pins and remapping
some of them to use the second UART would break existing users.

Suggested-by: L?szl? ?SHIN <laszlo@ashin.hu>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 2ce52ba74f73..c05b274ab1a9 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -98,9 +98,17 @@
 
 /* Exported on the micro USB connector J5 through an FTDI */
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
 	status = "okay";
 };
 
+/*
+ * Enabling the second UART on J17 (pins 24,26) is just a matter of copying the
+ * uart1 node from armada-3720-db.dts with one difference: it works with 1.8V
+ * TTL levels.
+ */
+
 /* J7 */
 &usb3 {
 	status = "okay";
-- 
2.11.0
