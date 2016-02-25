From: eric@anholt.net (Eric Anholt)
Date: Thu, 25 Feb 2016 10:41:00 -0800
Subject: [PATCH 4/5] ARM: bcm2835: Add a group for mapping pins 48-53 to
 sdhost.
In-Reply-To: <1456425661-26123-1-git-send-email-eric@anholt.net>
References: <1456425661-26123-1-git-send-email-eric@anholt.net>
Message-ID: <1456425661-26123-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pin group definition comes from downstream.  We don't have a
driver for sdhost integrated yet, but they've been experimenting with
it and it sounds useful to bring over.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 70a6814..0bb32cc 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -191,6 +191,10 @@
 				brcm,pins = <45>;
 				brcm,function = <BCM2835_FSEL_ALT0>;
 			};
+			sdhost_gpio48: sdhost_gpio48 {
+				brcm,pins = <48 49 50 51 52 53>;
+				brcm,function = <BCM2835_FSEL_ALT0>;
+			};
 			i2c0_gpio44: i2c0_gpio44 {
 				brcm,pins = <44 45>;
 				brcm,function = <BCM2835_FSEL_ALT1>;
-- 
2.7.0
