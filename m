From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  5 Nov 2014 17:01:25 +0100
Subject: [PATCH v2 09/11] ARM: at91/dt: add matrix node in sama5d3 dtsi
In-Reply-To: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415203287-21517-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
