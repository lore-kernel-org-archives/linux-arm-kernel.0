From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:26 +0200
Subject: [PATCH 17/32] ARM: bcm2835: Add a group for mapping pins 48-53 to
 sdhost.
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-18-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

This pin group definition comes from downstream.  We don't have a
driver for sdhost integrated yet, but they've been experimenting with
it and it sounds useful to bring over.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 28ed77f..3866fc7a 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -212,6 +212,10 @@
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
1.8.3.1
