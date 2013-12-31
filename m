From: jjhiblot@traphandler.com (jjhiblot at traphandler.com)
Date: Tue, 31 Dec 2013 17:32:14 +0100
Subject: [PATCH 6/6] at91: dt: sam9261: Added DM9000 in the device tree
In-Reply-To: <1388507534-10570-1-git-send-email-jjhiblot@traphandler.com>
References: <1388507534-10570-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1388507534-10570-7-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: jean-jacques hiblot <jean-jacques.hiblot@jdsu.com>

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261ek.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 11cf619..7a7997f 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -76,6 +76,35 @@
 		smc: smc at ffffec00 {
 			status = "okay";
 
+			ethernet at 30000000 {
+				compatible = "davicom,dm9000";
+				reg = <0x30000000 0x2 0x30000004 0x2>;
+				interrupt-parent = <&pioC>;
+				interrupts = <11 IRQ_TYPE_EDGE_BOTH>;
+				local-mac-address = [00 00 de ad be ef];
+				davicom,no-eeprom;
+
+				smc,cs = <2>;
+				smc,ncs_read_setup = <0>;
+				smc,nrd_setup = <2>;
+				smc,ncs_write_setup = <0>;
+				smc,nwe_setup = <2>;
+				smc,ncs_read_pulse = <8>;
+				smc,nrd_pulse = <4>;
+				smc,ncs_write_pulse = <8>;
+				smc,nwe_pulse = <4>;
+				smc,read_cycle = <16>;
+				smc,write_cycle = <16>;
+				smc,tdf_cycles = <1>;
+				smc,tdf_optimized = <0>;
+				smc,page_size = <0>;
+				smc,byte_access_type = <1>;
+				smc,bus_width = <1>;
+				smc,nwait_mode = <0>;
+				smc,read_mode = <1>;
+				smc,write_mode = <1>;
+			};
+
 			nand0: nand at 40000000 {
 				nand-bus-width = <8>;
 				nand-ecc-mode = "soft";
-- 
1.8.4.2
