From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 12 Feb 2015 16:06:25 +0800
Subject: [PATCH 3/4] ARM: at91: at91sam9g25ek/dts: enable ISI and ov2640
In-Reply-To: <1423728386-24544-1-git-send-email-josh.wu@atmel.com>
References: <1423728386-24544-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1423728386-24544-4-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ISI and ov2640 for at91sam9g25ek board.
Meantime, we need to disable the mmc1 and spi0 as they have pin conflict
with ISI.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 arch/arm/boot/dts/at91sam9g25ek.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 1e4c49c..9808990 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -16,10 +16,28 @@
 
 	ahb {
 		apb {
+			spi0: spi at f0000000 {
+				status = "disabled";
+			};
+
+			mmc1: mmc at f000c000 {
+				status = "disabled";
+			};
+
+			i2c0: i2c at f8010000 {
+				ov2640: camera at 0x30 {
+					status = "okay";
+				};
+			};
+
 			macb0: ethernet at f802c000 {
 				phy-mode = "rmii";
 				status = "okay";
 			};
 		};
+
+		isi: isi at f8048000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.9.1
