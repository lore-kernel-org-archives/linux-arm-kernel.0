From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 26 Jun 2016 23:06:22 +0200
Subject: [PATCH v2 2/2] ARM: dts: meson: fixed size of the meson-ir registers
In-Reply-To: <20160626210622.5257-1-martin.blumenstingl@googlemail.com>
References: <20160626210622.5257-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160626210622.5257-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the reference driver (and the datasheet of the newer
Meson8b/S805 and GXBB/S905 SoCs) there are 14 registers, each 32 bit
wide.
Adjust the register size to reflect that, as register offset 0x20 is
now also needed by the meson-ir driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
changes in v1 -> v2:
- new patch, this is needed because we are now trying to read/write
  offset 0x20 which is beyond the space which was reserved previously
  

 arch/arm/boot/dts/meson.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 8c77c87..0f5722a 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -147,7 +147,7 @@
 
 		ir_receiver: ir-receiver at c8100480 {
 			compatible= "amlogic,meson6-ir";
-			reg = <0xc8100480 0x20>;
+			reg = <0xc8100480 0x34>;
 			interrupts = <0 15 1>;
 			status = "disabled";
 		};
-- 
2.9.0
