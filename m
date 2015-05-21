From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 21 May 2015 14:32:35 +0200
Subject: [PATCH 3/3] ARM: dts: sun7i: Add uart4 support for BananaPro,
 disable uart2
In-Reply-To: <1432211555-25078-1-git-send-email-hdegoede@redhat.com>
References: <1432211555-25078-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1432211555-25078-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Ring <mail@michael-ring.org>

The BananaPro uses uart4 for the default rx/tx pins on the 40 pins connector,
so enable uart4.

Uart2 is also available at the bananapro io-pins, but like on the bananapi
the primary function of the pins is to act as gpios, see:
http://forum.lemaker.org/forum.php?mod=viewthread&tid=10852

Disable the uart2 node by default, but leave it in place so that people
can easily enable it.

Signed-off-by: Michael Ring <mail@michael-ring.org>
[hdegoede at redhat.com: Disable uart2 by default]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapro.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 45e2a02..4edb8a4 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -52,8 +52,9 @@
 
 	aliases {
 		serial0 = &uart0;
-		serial1 = &uart2;
+		serial1 = &uart4;
 		serial2 = &uart7;
+		serial3 = &uart2;
 	};
 
 	chosen {
@@ -253,6 +254,12 @@
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins_a>;
+	status = "disabled";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_b>;
 	status = "okay";
 };
 
-- 
2.4.1
