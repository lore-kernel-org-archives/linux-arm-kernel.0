From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 14 May 2016 19:57:29 +0200
Subject: [PATCH 3/4] ARM: dts: axp22x.dtsi: Add reg_drivebus node
In-Reply-To: <1463248650-16611-1-git-send-email-hdegoede@redhat.com>
References: <1463248650-16611-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1463248650-16611-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the drivebus regulator which is an (optional)
part of the axp221/axp223 pmic. Since this regulator may not be
available at all depending on the board, mark it as disabled by
default.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index cbafca6..6903d471 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -141,6 +141,11 @@
 			regulator-max-microvolt = <3000000>;
 			regulator-name = "rtc_ldo";
 		};
+
+		reg_drivebus: drivebus {
+			regulator-name = "drivebus";
+			status = "disabled";
+		};
 	};
 
 	usb_power_supply: usb_power_supply {
-- 
2.7.4
