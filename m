From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Sep 2015 15:36:00 +0200
Subject: [PATCH 1/6] ARM: dts: axp209: Add usb_power_supply child node to the
 ax209 node
Message-ID: <1442928966-6418-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node representing the usb power supply part of the axp209 pmic, note
that the usb power supply and the (to be added later) ac power supply will
each have their own child-node, so that they can be separately specified
as power-supply for other nodes using a power-supply property with a
phandle pointing to the right axp209 child-node.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/axp209.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 24c935c..051ab3b 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -89,4 +89,9 @@
 			regulator-name = "ldo5";
 		};
 	};
+
+	usb_power_supply: usb_power_supply {
+		compatible = "x-powers,axp202-usb-power-supply";
+		status = "disabled";
+	};
 };
-- 
2.4.3
