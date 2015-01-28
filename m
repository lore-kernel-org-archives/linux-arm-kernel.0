From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 28 Jan 2015 19:39:01 +0100
Subject: [PATCH 3/5] ARM: at91/dt: fix matrix compatible in at91sam9261.dtsi
In-Reply-To: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1422470343-25981-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1422470343-25981-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The matrix IP is referenced by other peripherals which are expecting a
syscon device. Moreover, the registers layout of the at91sam9260 and
at91sam9261 SoCs are not the same.
Update the compatible string accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 7b81a03..410d954 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -263,7 +263,7 @@
 			};
 
 			matrix: matrix at ffffee00 {
-				compatible = "atmel,at91sam9260-bus-matrix";
+				compatible = "atmel,at91sam9261-bus-matrix", "syscon";
 				reg = <0xffffee00 0x200>;
 			};
 
-- 
1.9.1
