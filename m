From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 14 May 2016 19:57:28 +0200
Subject: [PATCH 2/4] ARM: dts: axp22x.dtsi: Add usb_power_supply node
In-Reply-To: <1463248650-16611-1-git-send-email-hdegoede@redhat.com>
References: <1463248650-16611-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1463248650-16611-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the (optional) usbpower-supply of the
axp221 / axp223 pmic.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 0cfec50..cbafca6 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -142,4 +142,9 @@
 			regulator-name = "rtc_ldo";
 		};
 	};
+
+	usb_power_supply: usb_power_supply {
+		compatible = "x-powers,axp202-usb-power-supply";
+		status = "disabled";
+	};
 };
-- 
2.7.4
