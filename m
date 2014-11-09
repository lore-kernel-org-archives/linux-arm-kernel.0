From: merker@debian.org (Karsten Merker)
Date: Sun,  9 Nov 2014 14:28:34 +0100
Subject: [PATCH] ARM: dts: sunxi: Banana Pi: increase startup-delay for the
 GMAC PHY regulator
In-Reply-To: <1415539714-7652-1-git-send-email-merker@debian.org>
References: <1415539714-7652-1-git-send-email-merker@debian.org>
Message-ID: <1415539714-7652-2-git-send-email-merker@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the LeMaker Banana Pi, probing the external ethernet PHY connected
to the SoC's internal GMAC module sometimes fails.  The PHY power
supply is handled via a GPIO-controlled regulator, and the existing
regulator startup-delay of 50000us is too short to make sure that the
PHY is always fully powered up when it is queried by phylib.  To
guarantee a reliable PHY detection, the startup-delay has to be
increased to 60000us.

Signed-off-by: Karsten Merker <merker@debian.org>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 3de847d..36065d1 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -207,7 +207,7 @@
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <50000>;
+		startup-delay-us = <60000>;
 		enable-active-high;
 		gpio = <&pio 7 23 0>;
 	};
-- 
1.7.10.4
