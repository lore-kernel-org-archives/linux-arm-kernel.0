From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:06 +0100
Subject: [PATCH 11/12] arm64: dts: r8a7795: salvator-x: add bias setting for
 usb1_pins
In-Reply-To: <cover.1478251192.git.horms+renesas@verge.net.au>
References: <cover.1478251192.git.horms+renesas@verge.net.au>
Message-ID: <0751e1bd1e9e989df2d5f6a52c28b16093bc9c78.1478251192.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since this board doesn't mount pull-up/down registers for
USB1_{OVC,PWEN} pins, we should enable bias setting to pull these
pins up/down.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index da3e996ba121..bcaf4008d32d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -309,8 +309,20 @@
 	};
 
 	usb1_pins: usb1 {
-		groups = "usb1";
-		function = "usb1";
+		mux {
+			groups = "usb1";
+			function = "usb1";
+		};
+
+		ovc {
+			pins = "GP_6_27";
+			bias-pull-up;
+		};
+
+		pwen {
+			pins = "GP_6_26";
+			bias-pull-down;
+		};
 	};
 
 	usb2_pins: usb2 {
-- 
2.7.0.rc3.207.g0ac5344
