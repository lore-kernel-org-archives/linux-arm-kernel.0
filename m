From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:20 +0200
Subject: [PATCH 08/16] deps: dts: kirkwood: dockstar: add dependency ehci ->
 usb power regulator
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-9-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serves as an example how easy it is to fix an initialization order
if the order depends on the DT. No source code changes will be necessary.

If you look at the dependency graph for the dockstar, you will see that
there is no dependency between ehci and the usb power regulator. This
ends up with the fact that the regulator will be initialized after ehci.

Fix this by adding one dependency to the .dts.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/boot/dts/kirkwood-dockstar.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index 8497363..426d8840 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -107,3 +107,7 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&usb0 {
+	dependencies = <&usb_power>;
+};
-- 
2.1.0
