From: marek@goldelico.com (Marek Belisko)
Date: Sat, 25 Jan 2014 22:28:57 +0100
Subject: [PATCH 3/9] ARM: dts: omap3-gta04: Fix mmc1 properties.
In-Reply-To: <1390685343-11663-1-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Message-ID: <1390685343-11663-4-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Does not have an aux supply, and must be non-removable.

Otherwise it is removed during suspend and filesystem gets confused.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/arm/boot/dts/omap3-gta04.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index e315675..6011151 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -149,8 +149,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
 	bus-width = <4>;
+	ti,non-removable;
 };
 
 &mmc2 {
-- 
1.8.3.2
