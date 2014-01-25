From: marek@goldelico.com (Marek Belisko)
Date: Sat, 25 Jan 2014 22:28:58 +0100
Subject: [PATCH 4/9] ARM: dts: omap3-gta04: Enable mmc2 for wifi.
In-Reply-To: <1390685343-11663-1-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Message-ID: <1390685343-11663-5-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neilb@suse.de>

This requires vaux4.

Reset line isn't used yet, so wifi isn't reliable.
But it does work once per boot.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/arm/boot/dts/omap3-gta04.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 6011151..7e09410 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -79,6 +79,11 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+		vaux4: regulator-vaux4 {
+			compatible = "ti,twl4030-vaux4";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3150000>;
+		};
 	};
 };
 
@@ -154,7 +159,9 @@
 };
 
 &mmc2 {
-	status = "disabled";
+	vmmc-supply = <&vaux4>;
+	bus-width = <4>;
+	ti,non-removable;
 };
 
 &mmc3 {
-- 
1.8.3.2
