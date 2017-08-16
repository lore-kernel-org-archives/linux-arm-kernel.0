From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Aug 2017 02:38:46 +0200
Subject: [PATCH 4/5] arm64: dts: realtek: Add RTD1295 UART resets
In-Reply-To: <20170816003847.6208-1-afaerber@suse.de>
References: <20170816003847.6208-1-afaerber@suse.de>
Message-ID: <20170816003847.6208-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Associate the UART nodes with the corresponding reset controller bits.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 9f1dcd1fa8b3..e777200d84b9 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -123,6 +123,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <27000000>;
+			resets = <&iso_reset 8>;
 			status = "disabled";
 		};
 
@@ -132,6 +133,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
+			resets = <&reset2 28>;
 			status = "disabled";
 		};
 
@@ -141,6 +143,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
+			resets = <&reset2 27>;
 			status = "disabled";
 		};
 
-- 
2.12.3
