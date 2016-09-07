From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  7 Sep 2016 12:31:25 +0200
Subject: [PATCH 4/8] ARM: dts: bcm283x: Add a new EMMC pin group from the
 downstream tree.
In-Reply-To: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
Message-ID: <1473244289-20728-5-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

This will be used for having EMMC (sdhci-bcm2835.c) drive the
wireless.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 062d09db..b6b1950 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -257,6 +257,11 @@
 				brcm,pins = <32 33>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
 			};
+			emmc_gpio34: emmc_gpio34 {
+				brcm,pins = <34 35 36 37 38 39>;
+				brcm,function = <BCM2835_FSEL_ALT3>;
+				brcm,pull = <0 2 2 2 2 2>;
+			};
 			emmc_gpio48: emmc_gpio48 {
 				brcm,pins = <48 49 50 51 52 53>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
-- 
1.8.3.1
