From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 11 Mar 2016 22:01:09 +0100
Subject: [PATCH 3/3] ARM: dts: sunxi: Disable axp22x ldo_io# regulators by
 default
In-Reply-To: <1457730069-31760-1-git-send-email-hdegoede@redhat.com>
References: <1457730069-31760-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1457730069-31760-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of these as regulators conflicts with use of the gpio pins as
gpios, so disabled the ldo_io# regulators by default.

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
2.7.2
