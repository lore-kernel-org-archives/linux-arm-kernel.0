From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 17 Sep 2014 15:10:08 +0300
Subject: [PATCH v2 6/6] ARM: dts: cm-t54: setup omap_dwc3
In-Reply-To: <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
 <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1410955808-2174-7-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "extcon" and "vbus-supply" properties of DWC3 node.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 v2: No changes

 arch/arm/boot/dts/omap5-cm-t54.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index de76550..f712e23 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -631,6 +631,11 @@
 	phys = <0 &hsusb2_phy &hsusb3_phy>;
 };
 
+&usb3 {
+       extcon = <&extcon_usb3>;
+       vbus-supply = <&smps10_out1_reg>;
+};
+
 &cpu0 {
 	cpu0-supply = <&smps123_reg>;
 };
-- 
1.7.5.4
