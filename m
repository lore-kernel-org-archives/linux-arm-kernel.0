From: koen@dominion.thruhere.net (Koen Kooi)
Date: Thu, 12 Sep 2013 20:35:34 +0200
Subject: [PATCH v4 3/4] ARM: dts: am335x-bone-common: switch mmc1 to 4-bit mode
In-Reply-To: <1379010935-25943-1-git-send-email-koen@dominion.thruhere.net>
References: <1379010935-25943-1-git-send-email-koen@dominion.thruhere.net>
Message-ID: <1379010935-25943-4-git-send-email-koen@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The micro-SD slot hooks up all four data pins so lets' use them.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index bc8d1a2..303df81 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -291,6 +291,7 @@
 
 &mmc1 {
 	status = "okay";
+	bus-width = <0x4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
-- 
1.8.2.1
