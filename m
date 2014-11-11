From: merker@debian.org (Karsten Merker)
Date: Wed, 12 Nov 2014 00:01:46 +0100
Subject: [PATCH V2 1/1] ARM: dts: sunxi: Banana Pi: increase startup-delay for
 the GMAC PHY regulator
In-Reply-To: <1415746906-20835-1-git-send-email-merker@debian.org>
References: <1415539714-7652-1-git-send-email-merker@debian.org>
 <1415746906-20835-1-git-send-email-merker@debian.org>
Message-ID: <1415746906-20835-2-git-send-email-merker@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the LeMaker Banana Pi, probing the external ethernet PHY connected
to the SoC's internal GMAC module sometimes fails. The PHY power
supply is handled via a GPIO-controlled regulator, and the existing
regulator startup-delay of 50000us is too short to make sure that the
PHY is always fully powered up when it is queried by phylib. Tests
have shown that to provide a reliable PHY detection, the startup-delay
has to be increased to at least 60000us. To have a certain safety margin
and to cater for manufacturing variations between different boards,
the delay gets set to 100000us as discussed on the linux-arm-kernel
mailinglist.

Signed-off-by: Karsten Merker <merker@debian.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 3de847d..1cf1214 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -207,7 +207,7 @@
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <50000>;
+		startup-delay-us = <100000>;
 		enable-active-high;
 		gpio = <&pio 7 23 0>;
 	};
-- 
1.7.10.4
