From: s-anna@ti.com (Suman Anna)
Date: Fri, 6 Jan 2017 15:57:32 -0600
Subject: [PATCH v2 8/9] ARM: dts: keystone-k2e: Reserve MSM RAM for boot
 monitor
In-Reply-To: <20170106215733.41637-1-s-anna@ti.com>
References: <20170106215733.41637-1-s-anna@ti.com>
Message-ID: <20170106215733.41637-9-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone 2 boot monitor uses 32 KB of the MSM RAM @ 0x0c1f0000
on 66AK2E SoCs, so add a reserved child node for the same.

This address is aligned to the values used within the latest boot
monitor firmware [1] as of commit cf8b431e8b3b ("soc: Move load
address to end of MSMC").

[1] git://git.ti.com/processor-firmware/ks2-boot-monitor.git

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/keystone-k2e.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 256dcc87f36a..9d1d8a64d10e 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -88,6 +88,10 @@
 			ranges = <0x0 0x0c000000 0x200000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			sram-bm at 1f0000 {
+				reg = <0x001f0000 0x8000>;
+			};
 		};
 
 		dspgpio0: keystone_dsp_gpio at 02620240 {
-- 
2.10.2
