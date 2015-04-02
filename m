From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 2 Apr 2015 14:17:56 +0800
Subject: [PATCH] ARM: at91: sama5/dts: reduce the NFC command register map
Message-ID: <1427955477-9176-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 111573ccd89b ("mtd: atmel_nand: check NFC busy flag by HSMC_SR
instead of NFC cmd regs")
check NFC busy by nfc SR instead of NFC cmd regs. So we don't need to
map NFC cmd registers to include NFCBUSY bit.
That means we only need map 0x08000000 instead of 0x10000000 for NFC
cmd regs.

This patch reduce the NFC cmd regs map for sama5d3 & sama5d4.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
This patch is based on linux-next git repo.

 arch/arm/boot/dts/sama5d3.dtsi | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 261311b..5b2c235 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1445,7 +1445,7 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <
-					0x70000000 0x10000000	/* NFC Command Registers */
+					0x70000000 0x08000000	/* NFC Command Registers */
 					0xffffc000 0x00000070	/* NFC HSMC regs */
 					0x00200000 0x00100000	/* NFC SRAM banks */
 					>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index d986b41..87705ad 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -294,7 +294,7 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <
-					0x90000000 0x10000000	/* NFC Command Registers */
+					0x90000000 0x08000000	/* NFC Command Registers */
 					0xfc05c000 0x00000070	/* NFC HSMC regs */
 					0x00100000 0x00100000	/* NFC SRAM banks */
                                          >;
-- 
1.9.1
