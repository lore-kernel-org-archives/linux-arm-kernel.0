From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 25 Nov 2014 12:28:26 +0000
Subject: [PATCH v5 2/2] dt-bindings: Update documentation for
 "system-power-controller" and fix misspellings
In-Reply-To: <1416918506-9366-1-git-send-email-romain.perier@gmail.com>
References: <1416918506-9366-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1416918506-9366-3-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 .../devicetree/bindings/power/power-controller.txt   | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power-controller.txt b/Documentation/devicetree/bindings/power/power-controller.txt
index 845868b..4f7a3bc 100644
--- a/Documentation/devicetree/bindings/power/power-controller.txt
+++ b/Documentation/devicetree/bindings/power/power-controller.txt
@@ -1,18 +1,18 @@
-* Generic Poweroff capability
+* Generic system power control capability
 
-Power-management integrated circuits or miscellaneous harware components are
-sometimes able to control the system power. The device driver associated to these
-components might needs to define poweroff capability, which tells to the kernel
-how to switch off the system. The corresponding driver must have the standard
-property "poweroff-source" in its device node. This property marks the device as
-able to shutdown the system. In order to test if this property is found
-programmatically, use the helper function "of_system_has_poweroff_source" from
-of.h .
+Power-management integrated circuits or miscellaneous hardware components are
+sometimes able to control the system power. The device driver associated with these
+components might need to define this capability, which tells the kernel that
+it can be used to switch off the system. The corresponding device must have the
+standard property "system-power-controller" in its device node. This property
+marks the device as able to control the system power. In order to test if this
+property is found programmatically, use the helper function
+"of_device_is_system_power_controller" from of.h .
 
 Example:
 
 act8846: act8846 at 5 {
 	 compatible = "active-semi,act8846";
 	 status = "okay";
-	 poweroff-source;
+	 system-power-controller;
 }
-- 
1.9.1
