From: robh@kernel.org (Rob Herring)
Date: Thu,  9 Nov 2017 16:26:12 -0600
Subject: [PATCH 4/6] arm: dts: nspire: Add missing #phy-cells to usb-nop-xceiv
In-Reply-To: <20171109222614.5719-1-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
Message-ID: <20171109222614.5719-4-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
property. This is probably because the binding was the precursor to the phy
binding.

Fixes the following warning in nspire dts files:

Warning (phys_property): Missing property '#phy-cells' in node ...

Signed-off-by: Rob Herring <robh@kernel.org>
---
Doesn't seem to be a maintainer for nspire. Arnd, please apply.

 arch/arm/boot/dts/nspire.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index ee5a0bb22354..6aadf6e622d2 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -56,6 +56,7 @@
 
 	usb_phy: usb_phy {
 		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
 	};
 
 	vbus_reg: vbus_reg {
-- 
2.14.1
