From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 22 May 2015 16:33:04 +0200
Subject: [PATCH v2 2/2] ARM: dts: sun7i: Add uart4 support for BananaPro,
 disable uart2
In-Reply-To: <1432305184-8589-1-git-send-email-hdegoede@redhat.com>
References: <1432305184-8589-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1432305184-8589-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Ring <mail@michael-ring.org>

The BananaPro uses uart4 for the default rx/tx pins on the 40 pins connector,
so enable uart4.

Uart2 is also available at the bananapro io-pins, but like on the bananapi
the primary function of the pins is to act as gpios, see:
http://forum.lemaker.org/forum.php?mod=viewthread&tid=10852

Remove the uart2 node, people who want to use uart2 can do so with a
devicetree-overlay.

Signed-off-by: Michael Ring <mail@michael-ring.org>
[hdegoede at redhat.com: Remove uart2 node]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Remove uart2 node instead of disabling it
---
 arch/arm/boot/dts/sun7i-a20-bananapro.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 45e2a02..18fcc87 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -52,7 +52,7 @@
 
 	aliases {
 		serial0 = &uart0;
-		serial1 = &uart2;
+		serial1 = &uart4;
 		serial2 = &uart7;
 	};
 
@@ -250,9 +250,9 @@
 	status = "okay";
 };
 
-&uart2 {
+&uart4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins_a>;
+	pinctrl-0 = <&uart4_pins_b>;
 	status = "okay";
 };
 
-- 
2.4.1
