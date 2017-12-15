From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:54:32 +1030
Subject: [PATCH v2 08/19] ARM: dts: aspeed: Add clock phandle to GPIO
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-9-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables a feature where the driver can debounce inputs.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index afac0ca0cb10..fa52a01f50b5 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -144,6 +144,7 @@
 				reg = <0x1e780000 0x1000>;
 				interrupts = <20>;
 				gpio-ranges = <&pinctrl 0 0 220>;
+				clocks = <&syscon ASPEED_CLK_APB>;
 				interrupt-controller;
 			};
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index f3689caf6fe2..5e6db2aa5c23 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -187,6 +187,7 @@
 				reg = <0x1e780000 0x1000>;
 				interrupts = <20>;
 				gpio-ranges = <&pinctrl 0 0 220>;
+				clocks = <&syscon ASPEED_CLK_APB>;
 				interrupt-controller;
 			};
 
-- 
2.14.1
