From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 22 Sep 2016 00:09:36 +0200
Subject: [PATCH v2 3/6] ARM: dts: at91: sama5d2: Add secumod node
In-Reply-To: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
References: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160921220939.27924-4-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sama5d2 has a security module, add its node.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 353d0e5ec83b..0b62bff86f49 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1231,6 +1231,11 @@
 				clocks = <&pioA_clk>;
 			};
 
+			secumod at fc040000 {
+				compatible = "atmel,sama5d2-secumod", "syscon";
+				reg = <0xfc040000 0x100>;
+			};
+
 			tdes at fc044000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xfc044000 0x100>;
-- 
2.9.3
