From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 30 Mar 2018 17:28:49 +0200
Subject: [PATCH v5 1/8] ARM: davinci: dts: make psc0 a reset provider
In-Reply-To: <20180330152856.12297-1-brgl@bgdev.pl>
References: <20180330152856.12297-1-brgl@bgdev.pl>
Message-ID: <20180330152856.12297-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The psc driver registers with the reset framework as a provider. Add
the #reset-cells property to the psc0 node.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index a3b9a99b43ca..dad64dbf1f23 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -123,6 +123,7 @@
 			compatible = "ti,da850-psc0";
 			reg = <0x10000 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 			clocks = <&pll0_sysclk 1>, <&pll0_sysclk 2>,
 				 <&pll0_sysclk 4>, <&pll0_sysclk 6>,
-- 
2.16.3
