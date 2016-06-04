From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  4 Jun 2016 12:58:39 +0200
Subject: [PATCH v2] ARM: dts: sunxi: Add a startup delay for fixed regulator
 enabled phys
Message-ID: <1465037919-8497-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that recent kernels have a shorter timeout when scanning for
ethernet phys causing us to hit a timeout on boards where the phy's
regulator gets enabled just before scanning, which leads to non working
ethernet.

A 10ms startup delay seems to be enough to fix it, this commit adds a
20ms startup delay just to be safe.

This has been tested on a sun4i-a10-a1000 and sun5i-a10s-wobo-i5 board,
both of which have non-working ethernet on recent kernels without this
fix.

Cc: stable at vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add Cc stable
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts      | 1 +
 arch/arm/boot/dts/sun4i-a10-hackberry.dts  | 1 +
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts | 1 +
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index c92a1ae..fa70b8f 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -84,6 +84,7 @@
 		regulator-name = "emac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <20000>;
 		enable-active-high;
 		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 2b17c51..6de83a6 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -66,6 +66,7 @@
 		regulator-name = "emac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <20000>;
 		enable-active-high;
 		gpio = <&pio 7 19 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
index 7afc7a6..e28f080 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
@@ -80,6 +80,7 @@
 		regulator-name = "emac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <20000>;
 		enable-active-high;
 		gpio = <&pio 7 19 GPIO_ACTIVE_HIGH>;   /* PH19 */
 	};
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index 52d18ca..b5de75f 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -79,6 +79,7 @@
 		regulator-name = "emac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <20000>;
 		enable-active-high;
 		gpio = <&pio 0 2 GPIO_ACTIVE_HIGH>;
 	};
-- 
2.7.4
