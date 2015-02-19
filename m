From: balbi@ti.com (Felipe Balbi)
Date: Thu, 19 Feb 2015 13:57:08 -0600
Subject: [PATCH] arm: boot: dts: am437x-idk: fix sleep pinctrl state
Message-ID: <1424375828-26535-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we have i2c0 sleep pinctrl state but were passing
default state anyhow. Fix that.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-idk-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 22c2031dea17..378344271746 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -254,7 +254,7 @@
 	status = "okay";
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c0_pins_default>;
-	pinctrl-1 = <&i2c0_pins_default>;
+	pinctrl-1 = <&i2c0_pins_sleep>;
 	clock-frequency = <400000>;
 
 	at24 at 50 {
-- 
2.3.0
