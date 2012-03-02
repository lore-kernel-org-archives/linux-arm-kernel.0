From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  2 Mar 2012 11:07:23 +0100
Subject: [PATCH 1/2] ARM: dts: versatile-pb/ab fix MMC IRQs
Message-ID: <1330682843-21163-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMCI driver will not work without two IRQs since this is not
flagged as a single-irq variant. Looking through the complex IRQ
definition for the MMCI on the versatile (including an #if 1
statement forcing MMCI IRQ0 to the VIC) this appears to the the
correct IRQ number for both models.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Niklas Hernaeus <niklas.hernaeus@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/versatile-ab.dts |    2 +-
 arch/arm/boot/dts/versatile-pb.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 0b32925..e2fe319 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -173,7 +173,7 @@
 			mmc at 5000 {
 				compatible = "arm,primecell";
 				reg = < 0x5000 0x1000>;
-				interrupts = <22>;
+				interrupts = <22 34>;
 			};
 			kmi at 6000 {
 				compatible = "arm,pl050", "arm,primecell";
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index 1664610..7e81752 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -41,7 +41,7 @@
 			mmc at b000 {
 				compatible = "arm,primecell";
 				reg = <0xb000 0x1000>;
-				interrupts = <23>;
+				interrupts = <23 34>;
 			};
 		};
 	};
-- 
1.7.7.6
