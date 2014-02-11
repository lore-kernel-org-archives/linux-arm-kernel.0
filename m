From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Feb 2014 14:02:37 +0100
Subject: [PATCH] ARM: ux500: disable msp2 device tree node
Message-ID: <1392123757-7982-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 70b41abc151f9
"ARM: ux500: move MSP pin control to the device tree"
accidentally activated MSP2, giving rise to a boot scroll
scream as the kernel attempts to probe a driver for it and
fails to obtain DMA channel 14.

Fix this up by marking the node disabled again.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC guys, can you please apply this patch directly
for fixes, there is no point to send a pull request with a
single patch in it.
---
 arch/arm/boot/dts/ste-href.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 0c1e8d871ed1..6cb9b68e2188 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -188,7 +188,6 @@
 		msp2: msp at 80117000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&msp2_default_mode>;
-			status = "okay";
 		};
 
 		msp3: msp at 80125000 {
-- 
1.8.5.3
