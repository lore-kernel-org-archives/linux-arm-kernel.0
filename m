From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 22:31:35 +0100
Subject: [PATCH] ARM: realview: remove eb-mp clcd IRQ
Message-ID: <20171221213146.3146805-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a dtc warning about the CLCD interrupt being invalid:

arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000

According to the datasheet I found and the old board file, this
line is not connected, so I'm removing the respective properties here.

Link: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0411d/index.html
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
index 7b8d90b7aeea..e45548ca229a 100644
--- a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
@@ -151,8 +151,9 @@
 };
 
 &charlcd {
-	interrupt-parent = <&intc>;
-	interrupts = <0  IRQ_TYPE_LEVEL_HIGH>;
+	/* CLCD is not connected here */
+	/delete-property/interrupt-parent;
+	/delete-property/interrupts;
 };
 
 &serial0 {
-- 
2.9.0
