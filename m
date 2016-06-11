From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 11 Jun 2016 15:53:03 +0200
Subject: [PATCH 3/6] ARM: dts: axp22x.dtsi: Add reg_drivebus node
In-Reply-To: <1465653186-953-1-git-send-email-hdegoede@redhat.com>
References: <1465653186-953-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1465653186-953-4-git-send-email-hdegoede@redhat.com>
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
index 0401787..458b668 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -141,6 +141,11 @@
 			regulator-max-microvolt = <3000000>;
 			regulator-name = "rtc_ldo";
 		};
+
+		reg_drivevbus: drivevbus {
+			regulator-name = "drivevbus";
+			status = "disabled";
+		};
 	};
 
 	usb_power_supply: usb_power_supply {
-- 
2.7.4
