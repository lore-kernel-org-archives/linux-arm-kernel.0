From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Mar 2017 00:28:15 +0100
Subject: [PATCH 3/6] ARM: dts: augment Moxa ART GPIO node
In-Reply-To: <20170312232818.26304-1-linus.walleij@linaro.org>
References: <20170312232818.26304-1-linus.walleij@linaro.org>
Message-ID: <20170312232818.26304-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Moxa ART GPIO is a Faraday FTGPIO010. Augment the DTS node
to indicate both compatible values for the SoC and the IP part.
Also increase the register range to 0x100, it has at least 0x48
bytes of registers, and a few extra will not hurt.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/moxart.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index 1fd27ed65a01..10a8184e0ce9 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -66,8 +66,8 @@
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
