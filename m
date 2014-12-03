From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  3 Dec 2014 21:44:12 +0100
Subject: [PATCH v5 08/11] ARM: at91/dt: add HSMC (Static Memory Controller)
 node in sama5d3 dtsi
In-Reply-To: <1417639455-17410-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417639455-17410-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417639455-17410-9-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SMC node in sama5d3 dtsi.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 5f4144d..9f1eed5 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -395,6 +395,11 @@
 				clock-names = "tdes_clk";
 			};
 
+			hsmc: hsmc at ffffc000 {
+				compatible = "atmel,sama5d3-smc", "syscon";
+				reg = <0xffffc000 0x1000>;
+			};
+
 			dma0: dma-controller at ffffe600 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffe600 0x200>;
-- 
1.9.1
