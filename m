From: stefan@agner.ch (Stefan Agner)
Date: Wed, 17 Feb 2016 15:44:16 -0800
Subject: [PATCH] ARM: dts: vf-colibri: disable write-protection for SD-card
Message-ID: <1455752656-4040-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Colibri standard does not define a pin for SD-Card write-
protection. Use the disable-wp property to indicate that there
is no physical WP line present.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index ff6f58e..e49bbbc 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -92,6 +92,7 @@
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
 	cd-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+	disable-wp;
 };
 
 &fec1 {
-- 
2.7.1
