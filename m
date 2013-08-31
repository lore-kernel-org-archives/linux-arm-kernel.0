From: joelf@ti.com (Joel Fernandes)
Date: Fri, 30 Aug 2013 20:19:39 -0500
Subject: [PATCH v2] ARM: dts: add AM33XX EDMA support
In-Reply-To: <521B1380.3030908@baylibre.com>
References: <1377505784-9820-1-git-send-email-bigeasy@linutronix.de>
 <521B1380.3030908@baylibre.com>
Message-ID: <522144AB.9010802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On 08/26/2013 03:36 AM, Benoit Cousson wrote:
> - minus all the TI emails which are not working anymore :-(
> 
> I've just sent my previous email too soon...
> 
> Now the patch is different :-) I'll take that one.

Unfortunately this patch is still missing from your latest pull request:

Subject "[GIT PULL] ARM: OMAP: Device Tree for 3.12 take #2"
  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
tags/for_3.12/dts_signed  (commit 4843be165c10f9886c87eeb20acf19a3ddec6653)

Below is a scissor patch that cleanly applies on above branch.

Thanks,

-Joel

--->8----
From: Matt Porter <mporter@ti.com>
Subject: [PATCH] ARM: dts: add AM33XX EDMA support

Adds AM33XX EDMA support to the am33xx.dtsi as documented in
Documentation/devicetree/bindings/dma/ti-edma.txt

v2 changes:
Drop DT entries that are non-hardware-description Joel Fernandes <joelf@ti.com>
Discussion in [1].

v3 changes: Changed node name from "edma: edma@" to "edma: dma-controller@"
by Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[1] https://patchwork.kernel.org/patch/2226761/

Signed-off-by: Matt Porter <mporter@ti.com>
Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 5996d63..f5869ed 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -101,6 +101,18 @@
 			reg = <0x48200000 0x1000>;
 		};

+		edma: dma-controller at 49000000 {
+			compatible = "ti,edma3";
+			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
+			reg =	<0x49000000 0x10000>,
+				<0x44e10f90 0x10>;
+			interrupts = <12 13 14>;
+			#dma-cells = <1>;
+			dma-channels = <64>;
+			ti,edma-regions = <4>;
+			ti,edma-slots = <256>;
+		};
+
 		gpio0: gpio at 44e07000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
-- 
1.8.1.2
