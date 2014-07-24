From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 25 Jul 2014 01:00:20 +0200
Subject: [PATCH v2 11/11] ARM: dts: zynq: Add AXI clkgen for Parallella
In-Reply-To: <1406242820-20140-1-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
Message-ID: <1406242820-20140-12-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm/boot/dts/zynq-parallella.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 65fbd8b..d2eefad 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -57,6 +57,13 @@
 			};
 		};
 
+		axi_clkgen: axi-clkgen at 66000000 {
+			compatible = "adi,axi-clkgen-1.00.a";
+			reg = <0x66000000 0x10000>;
+			#clock-cells = <0>;
+			clocks = <&clkc 17>;
+		};
+
 		audio_clock: audio-clock {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-- 
1.9.3
