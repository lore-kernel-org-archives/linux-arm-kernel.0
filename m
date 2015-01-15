From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 15 Jan 2015 13:47:29 +0100
Subject: [PATCH] ARM: zynq: DT: Fix binding for cadence WDT
Message-ID: <0c27264afa3356979d803d53d329458039f64485.1421326047.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on:
"devicetree: Add Cadence WDT devicetree bindings documentation"
(sha1: 191891c0378f44aec8e06e889a08d0b76fe6c5cb)

- compatible string is cdns,wdt-r1p2
- remove device_type property
- remove int reset property (reset-on-timeout is bool)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index c9b9722c0c59..a5cd2eda3edf 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -342,12 +342,10 @@

 		watchdog0: watchdog at f8005000 {
 			clocks = <&clkc 45>;
-			compatible = "xlnx,zynq-wdt-r1p2";
-			device_type = "watchdog";
+			compatible = "cdns,wdt-r1p2";
 			interrupt-parent = <&intc>;
 			interrupts = <0 9 1>;
 			reg = <0xf8005000 0x1000>;
-			reset = <0>;
 			timeout-sec = <10>;
 		};
 	};
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/0671054d/attachment.sig>
