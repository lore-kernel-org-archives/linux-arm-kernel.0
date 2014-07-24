From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 25 Jul 2014 01:00:19 +0200
Subject: [PATCH v2 10/11] ARM: dts: zynq: Add SPDIF for Parallella
In-Reply-To: <1406242820-20140-1-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
Message-ID: <1406242820-20140-11-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm/boot/dts/zynq-parallella.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 8beaacc..65fbd8b 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -56,6 +56,21 @@
 				xlnx,genlock-mode = <0>;
 			};
 		};
+
+		audio_clock: audio-clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <12288000>;
+		};
+
+		axi-spdif-tx at 0x75c00000 {
+			compatible = "adi,axi-spdif-tx-1.00.a";
+			reg = <0x75c00000 0x1000>;
+			clocks = <&clkc 15>, <&audio_clock>;
+			clock-names = "axi", "ref";
+			dmas = <&dmac_s 0>;
+			dma-names = "tx";
+		};
 	};
 };
 
-- 
1.9.3
