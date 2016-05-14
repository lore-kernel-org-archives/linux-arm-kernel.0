From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 14 May 2016 19:57:27 +0200
Subject: [PATCH 1/4] ARM: dts: axp22x.dtsi: Disable axp22x ldo_io# regulators
 by default
Message-ID: <1463248650-16611-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of these as regulators conflicts with use of the gpio pins as
gpios, so disabled the ldo_io# regulators by default, this avoids
the regulator core touching them when the pins are used as gpios.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/axp22x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 76302f5..0cfec50 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -126,10 +126,12 @@
 
 		reg_ldo_io0: ldo_io0 {
 			regulator-name = "ldo_io0";
+			status = "disabled";
 		};
 
 		reg_ldo_io1: ldo_io1 {
 			regulator-name = "ldo_io1";
+			status = "disabled";
 		};
 
 		reg_rtc_ldo: rtc_ldo {
-- 
2.7.4
