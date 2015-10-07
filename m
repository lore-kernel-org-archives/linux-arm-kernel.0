From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Oct 2015 10:57:54 +0900
Subject: [PATCH 17/28] ARM: shmobile: r8a7790: lager: add pinmux for iic0
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
Message-ID: <535118cac9e0705bf58de0604060f644bee7472d.1444182812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

It seems we used to rely on the default pinmux setting of this HW, but
currently we need to explicitly set the pinmux to access this bus. It is
better style, too.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 6f5d7f50d5ca..c553abd711ee 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -342,6 +342,11 @@
 		renesas,function = "msiof1";
 	};
 
+	iic0_pins: iic0 {
+		renesas,groups = "iic0";
+		renesas,function = "iic0";
+	};
+
 	iic1_pins: iic1 {
 		renesas,groups = "iic1";
 		renesas,function = "iic1";
@@ -517,6 +522,8 @@
 
 &iic0	{
 	status = "okay";
+	pinctrl-0 = <&iic0_pins>;
+	pinctrl-names = "default";
 };
 
 &iic1	{
-- 
2.1.4
