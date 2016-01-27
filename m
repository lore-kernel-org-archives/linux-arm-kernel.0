From: blogic@openwrt.org (John Crispin)
Date: Wed, 27 Jan 2016 12:47:35 +0100
Subject: [PATCH V3 1/4] dt-bindings: mfd: Add bindings for the MediaTek MT6323
 PMIC
Message-ID: <1453895258-44369-1-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: devicetree at vger.kernel.org
---
 Documentation/devicetree/bindings/mfd/mt6397.txt |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 15043e6..949c85f 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -1,6 +1,6 @@
-MediaTek MT6397 Multifunction Device Driver
+MediaTek MT6397/MT6323 Multifunction Device Driver
 
-MT6397 is a multifunction device with the following sub modules:
+MT6397/MT6323 is a multifunction device with the following sub modules:
 - Regulator
 - RTC
 - Audio codec
@@ -8,14 +8,14 @@ MT6397 is a multifunction device with the following sub modules:
 - Clock
 
 It is interfaced to host controller using SPI interface by a proprietary hardware
-called PMIC wrapper or pwrap. MT6397 MFD is a child device of pwrap.
+called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
 See the following for pwarp node definitions:
 Documentation/devicetree/bindings/soc/pwrap.txt
 
 This document describes the binding for MFD device and its sub module.
 
 Required properties:
-compatible: "mediatek,mt6397"
+compatible: "mediatek,mt6397" or "mediatek,mt6323"
 
 Optional subnodes:
 
@@ -26,6 +26,8 @@ Optional subnodes:
 	Required properties:
 		- compatible: "mediatek,mt6397-regulator"
 	see Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
+		- compatible: "mediatek,mt6323-regulator"
+	see Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
 - codec
 	Required properties:
 		- compatible: "mediatek,mt6397-codec"
-- 
1.7.10.4
