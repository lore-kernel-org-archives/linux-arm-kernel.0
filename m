From: manu@freebsd.org (Emmanuel Vadot)
Date: Fri, 27 Jul 2018 13:52:02 +0200
Subject: [PATCH v3 1/4] arm64: dts: allwinner: a64: Add SID node
Message-ID: <20180727115205.20955-1-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 have a SID controller which consist of EFUSE (starting at 0x200)
and three registers to read/write some of the protected efuses.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..69c0d9362553 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -227,6 +227,11 @@
 			#size-cells = <0>;
 		};
 
+		sid: eeprom at 1c14000 {
+			compatible = "allwinner,sun50i-a64-sid";
+			reg = <0x1c14000 0x400>;
+		};
+
 		usb_otg: usb at 1c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
-- 
2.18.0
