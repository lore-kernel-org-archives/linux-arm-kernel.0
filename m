From: s-anna@ti.com (Suman Anna)
Date: Fri, 6 Jan 2017 15:57:26 -0600
Subject: [PATCH v2 2/9] ARM: dts: keystone-k2l: Add MSM RAM node
In-Reply-To: <20170106215733.41637-1-s-anna@ti.com>
References: <20170106215733.41637-1-s-anna@ti.com>
Message-ID: <20170106215733.41637-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the RAM managed by the Multicore Shared Memory Controller (MSMC)
as a mmio-sram node. The 66AK2L SoCs have 2 MB of such memory. Any
specific MSM memory range needed by a software module ought to be
reserved using an appropriate child node.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v2: No code changes, SoC name in commit message corrected to use 66AK2L

 arch/arm/boot/dts/keystone-k2l.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index 0c5e74e79ba2..edc08de4e196 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -204,6 +204,14 @@
 			};
 		};
 
+		msm_ram: msmram at 0c000000 {
+			compatible = "mmio-sram";
+			reg = <0x0c000000 0x200000>;
+			ranges = <0x0 0x0c000000 0x200000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		dspgpio0: keystone_dsp_gpio at 02620240 {
 			compatible = "ti,keystone-dsp-gpio";
 			gpio-controller;
-- 
2.10.2
