From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon,  5 Feb 2018 16:32:04 +0100
Subject: [PATCH] ARM: dts: da850-lcdk: add clock properties to the nand node
Message-ID: <20180205153204.20317-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Make nand work with the common clock framework by specifying which
clock should be used and what name to look up.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index a1f4d6d5a569..2e725c57a0fe 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -264,6 +264,9 @@
 			reg = <0 0x02000000 0x02000000
 			       1 0x00000000 0x00008000>;
 
+			clocks = <&psc0 3>;
+			clock-names = "aemif";
+
 			ti,davinci-chipselect = <1>;
 			ti,davinci-mask-ale = <0>;
 			ti,davinci-mask-cle = <0>;
-- 
2.16.1
