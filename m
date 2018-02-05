From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon,  5 Feb 2018 16:52:22 +0100
Subject: [PATCH] ARM: dts: da850-evm: add clock properties to the nand node
Message-ID: <20180205155222.22189-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Make nand work with the common clock framework by specifying which
clock should be used and what name to look up.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index a86a8a1816f2..2602ad8e99ee 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -296,6 +296,9 @@
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
