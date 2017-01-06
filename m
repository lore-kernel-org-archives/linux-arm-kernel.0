From: s-anna@ti.com (Suman Anna)
Date: Fri, 6 Jan 2017 15:57:30 -0600
Subject: [PATCH v2 6/9] ARM: dts: keystone-k2hk: Reserve MSM RAM for boot
 monitor
In-Reply-To: <20170106215733.41637-1-s-anna@ti.com>
References: <20170106215733.41637-1-s-anna@ti.com>
Message-ID: <20170106215733.41637-7-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone 2 boot monitor uses 32 KB of the MSM RAM @ 0x0c5f0000
on 66AK2H SoCs, so add a reserved child node for the same.

This address is aligned to the values used within the latest boot
monitor firmware [1] as of commit cf8b431e8b3b ("soc: Move load
address to end of MSMC").

[1] git://git.ti.com/processor-firmware/ks2-boot-monitor.git

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2hk.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2hk.dtsi b/arch/arm/boot/dts/keystone-k2hk.dtsi
index 39e88d815235..e0780f111537 100644
--- a/arch/arm/boot/dts/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -52,6 +52,10 @@
 			ranges = <0x0 0x0c000000 0x600000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			sram-bm at 5f0000 {
+				reg = <0x5f0000 0x8000>;
+			};
 		};
 
 		dspgpio0: keystone_dsp_gpio at 02620240 {
-- 
2.10.2
