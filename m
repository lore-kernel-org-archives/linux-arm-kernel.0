From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 1 Apr 2014 15:12:43 +0800
Subject: [PATCH] ARM: at91: fix spi cs on sama5d3 Xplained board
Message-ID: <1396336363-13709-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PD16 is the CS3 for SPI0 while not SPI1.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
This patch is based on v3.14-rc8

 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index ce13755..4537259 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -34,7 +34,7 @@
 			};
 
 			spi0: spi at f0004000 {
-				cs-gpios = <&pioD 13 0>;
+				cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
 				status = "okay";
 			};
 
@@ -79,7 +79,7 @@
 			};
 
 			spi1: spi at f8008000 {
-				cs-gpios = <&pioC 25 0>, <0>, <0>, <&pioD 16 0>;
+				cs-gpios = <&pioC 25 0>;
 				status = "okay";
 			};
 
-- 
1.8.5.2
