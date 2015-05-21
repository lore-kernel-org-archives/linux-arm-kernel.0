From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 21 May 2015 14:32:34 +0200
Subject: [PATCH 2/3] ARM: dts: sun7i: Add uart2 support for BananaPi
In-Reply-To: <1432211555-25078-1-git-send-email-hdegoede@redhat.com>
References: <1432211555-25078-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1432211555-25078-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Ring <mail@michael-ring.org>

Uart2 is available at the bananapi io-pins, add a dts node for this
(so that people can easily enable it) but leave it disabled as the pins
are primarily intended for gpio as documented here:
http://wiki.lemaker.org/Pin_definition

Signed-off-by: Michael Ring <mail@michael-ring.org>
[hdegoede at redhat.com: Disable uart2 by default]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 9f7b472..3e357ef 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -58,6 +58,7 @@
 		serial0 = &uart0;
 		serial1 = &uart3;
 		serial2 = &uart7;
+		serial3 = &uart2;
 	};
 
 	chosen {
@@ -204,6 +205,12 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins_a>;
+	status = "disabled";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins_b>;
-- 
2.4.1
