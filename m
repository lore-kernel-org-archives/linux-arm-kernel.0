From: nm@ti.com (Nishanth Menon)
Date: Sat, 16 Dec 2017 14:40:35 -0600
Subject: [PATCH V2 3/8] ARM: dts: keystone: Get rid of usage of skeleton.dtsi
In-Reply-To: <20171216204040.18017-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com> <20171216204040.18017-1-nm@ti.com>
Message-ID: <20171216204040.18017-4-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

skeleton.dtsi doesn't offer us any real benefits with most of the
parameters being overridden. So, just drop the same entirely and
introduce appropriate changes for chosen node and memory back to
our top level definition.

This also squashes the following warnings with W=1:

arch/arm/boot/dts/keystone-k2hk-evm.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2l-evm.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2e-evm.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since v1: Typo fixes in commit message

v1: https://patchwork.kernel.org/patch/10115097/

 arch/arm/boot/dts/keystone.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 0e8d094515cc..01496910587a 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -6,8 +6,6 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "ti,keystone";
 	model = "Texas Instruments Keystone 2 SoC";
@@ -22,7 +20,10 @@
 		spi2 = &spi2;
 	};
 
-	memory {
+	chosen { };
+
+	memory: memory at 80000000 {
+		device_type = "memory";
 		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
 	};
 
-- 
2.14.1
