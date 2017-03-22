From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Mar 2017 12:12:09 +0100
Subject: [PATCH] ARM: dts: augment Moxa ART GPIO node
Message-ID: <20170322111209.14571-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Moxa ART GPIO is a Faraday FTGPIO010. Augment the DTS node
to indicate both compatible values for the SoC and the IP part.
Also increase the register range to 0x100, it has at least 0x48
bytes of registers, and a few extra will not hurt.

Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please just apply this to DT for-next like the
other Moxa Faraday cleanup patch.
---
 arch/arm/boot/dts/moxart.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index 64f2f44235d0..e86f8c905ac5 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -67,8 +67,8 @@
 		gpio: gpio at 98700000 {
 			gpio-controller;
 			#gpio-cells = <2>;
-			compatible = "moxa,moxart-gpio";
-			reg = <0x98700000 0xC>;
+			compatible = "moxa,moxart-gpio", "faraday,ftgpio010";
+			reg = <0x98700000 0x100>;
 		};
 
 		rtc: rtc {
-- 
2.9.3
