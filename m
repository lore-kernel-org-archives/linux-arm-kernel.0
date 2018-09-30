From: aford173@gmail.com (Adam Ford)
Date: Sun, 30 Sep 2018 11:01:18 -0500
Subject: [PATCH] ARM: dts: da850-evm: Enable tca6416 on baseboard
Message-ID: <20180930160118.7210-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a GPIO expander on both the UI board as well as the
baseboard.  This patch enables the second tca6416 and identifies
it as being on the baseboard using _bb as the suffix.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f9b757905845..a3c9b346721d 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -221,6 +221,12 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+	tca6416_bb: gpio at 21 {
+		compatible = "ti,tca6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &wdt {
-- 
2.17.1
