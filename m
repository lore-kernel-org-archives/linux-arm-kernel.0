From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sun, 5 Feb 2017 10:53:02 +0100 (CET)
Subject: [PATCH 14/22] ARM: dts: add a devicetree for Raidsonic NAS
 IB-4220-B
In-Reply-To: <20170122122254.10764-1-linus.walleij@linaro.org>
References: <20170122122254.10764-1-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1702051051090.26313@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

please add right baudrate and partition scheme for NAS 4220

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

---
 arch/arm/boot/dts/gemini-nas4220b.dts | 36 +++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 0b30cdeb2354..7668ba52158e 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -19,7 +19,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200n8";
+		bootargs = "console=ttyS0,19200n8";
 		stdout-path = &uart0;
 	};
 
@@ -64,7 +64,39 @@
 			status = "okay";
 			/* 16MB of flash */
 			reg = <0x30000000 0x01000000>;
-			/* TODO: add flash partitions here */
+
+			partition at 0 {
+				label = "RedBoot";
+				reg = <0x00000000 0x00020000>;
+				read-only;
+			};
+			partition at 20000 {
+				label = "Kernel";
+				reg = <0x00020000 0x00300000>;
+			};
+			partition at 320000 {
+				label = "Ramdisk";
+				reg = <0x00320000 0x00600000>;
+			};
+			partition at 920000 {
+				label = "Application";
+				reg = <0x00920000 0x00600000>;
+			};
+			partition at f20000 {
+				label = "VCTL";
+				reg = <0x00f20000 0x00020000>;
+				read-only;
+			};
+			partition at f40000 {
+				label = "CurConf";
+				reg = <0x00f40000 0x000a0000>;
+				read-only;
+			};
+			partition at fe0000 {
+				label = "FIS directory";
+				reg = <0x00fe0000 0x00020000>;
+				read-only;
+			};
 		};
 	};
 };
-- 
2.11.0
