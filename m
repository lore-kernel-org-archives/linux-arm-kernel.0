From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 9 May 2016 18:34:29 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2: use "atmel,
 sama5d3-nfc" compatible for nfc
In-Reply-To: <1462776680-5284-3-git-send-email-wenyou.yang@atmel.com>
References: <1462776680-5284-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1462811669-10107-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

An error in documentation of the NAND Flash Controller (NFC) led to choose
another compatibility string for sama5d2 with an impact on the NAND flash
ready/busy information. It was producing the error message:

atmel_nand 80000000.nand: Time out to wait for interrupt: 0x08000000

and had an impact on performance.

So, switch back to the classical "atmel,sama5d3-nfc" compatibility string for
this SoC which gives the proper ready/busy bit information. The NAND flash
driver will be updated to remove the support for this different
implementation.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
[nicolas.ferre at atmel.com: change commit message]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Wenyou, Romain,

I plan to send this patch for 4.6-rc as a fix tomorrow (my time). Can you
please tell me if it's okay on your side.
I revised the commit message just to justify the very late "fix" sending of
this patch...

Thanks for your help, bye.
  Nicolas.


 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 78996bdbd3df..9817090c1b73 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -280,7 +280,7 @@
 			status = "disabled";
 
 			nfc at c0000000 {
-				compatible = "atmel,sama5d4-nfc";
+				compatible = "atmel,sama5d3-nfc";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = < /* NFC Command Registers */
-- 
2.1.3
