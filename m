From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:17 +0100
Subject: [PATCH 11/13] ARM: dts: omap3-gta04: only power DSS when necessary.
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-12-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neil@brown.name>

i.e. configure vpll2 as a supply for the dss rather
than being always-on.

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 08f0b25..228e79b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -393,16 +393,12 @@
 	regulator-max-microvolt = <3150000>;
 };
 
-/* Needed to power the DPI pins */
-&vpll2 {
-	regulator-always-on;
-};
-
 &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = < &dss_dpi_pins >;
 
 	status = "okay";
+	vdds_dsi-supply = <&vpll2>;
 
 	port {
 		dpi_out: endpoint {
-- 
1.9.1
