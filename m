From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  1 Dec 2014 11:27:25 +0100
Subject: [PATCH v3 09/11] ARM: at91/dt: add matrix node in sama5d3 dtsi
In-Reply-To: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417429647-3419-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add matrix node in sama5d3 dtsi so that it can be referenced by other
devices.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 9f1eed5..d49dab7 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -425,6 +425,11 @@
 				clock-names = "ddrck", "mpddr";
 			};
 
+			matrix: matrix at ffffec00 {
+				compatible = "atmel,sama5d3-matrix", "syscon";
+				reg = <0xffffec00 0x200>;
+			};
+
 			dbgu: serial at ffffee00 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
-- 
1.9.1
