From: nm@ti.com (Nishanth Menon)
Date: Sat, 16 Dec 2017 14:40:36 -0600
Subject: [PATCH V2 4/8] ARM: dts: keystone: Add missing unit name to interrupt
 controller
In-Reply-To: <20171216204040.18017-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com> <20171216204040.18017-1-nm@ti.com>
Message-ID: <20171216204040.18017-5-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add base address for GIC as unit address. This also squashes the
following warnings when built with W=1:
arch/arm/boot/dts/keystone-k2hk-evm.dtb: Warning (unit_address_vs_reg): Node /interrupt-controller has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2l-evm.dtb: Warning (unit_address_vs_reg): Node /interrupt-controller has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2e-evm.dtb: Warning (unit_address_vs_reg): Node /interrupt-controller has a reg or ranges property, but no unit name

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1: rebase

V1: https://patchwork.kernel.org/patch/10115099/

 arch/arm/boot/dts/keystone.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 01496910587a..93ea5c69ea77 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -27,7 +27,7 @@
 		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
 	};
 
-	gic: interrupt-controller {
+	gic: interrupt-controller at 2561000 {
 		compatible = "arm,gic-400", "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
-- 
2.14.1
