From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:19 +0100
Subject: [PATCH 13/13] ARM: dts: omap3-gta04: Disable keypad
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-14-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neil@brown.name>

The twl4030 keypad is not wired up in the gta04, so mark it disabled
to avoid pointless initialization.

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 8d2b0a1..b3ecf1f 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -342,6 +342,10 @@
 	status = "disabled";
 };
 
+&twl_keypad {
+	status = "disabled";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
-- 
1.9.1
