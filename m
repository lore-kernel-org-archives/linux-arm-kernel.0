From: d-gerlach@ti.com (Dave Gerlach)
Date: Sun, 18 Feb 2018 21:35:05 -0600
Subject: [PATCH 9/9] ARM: dts: am4372: Mark omap_l3_noc with ti,no-idle
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1519011305-17822-10-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can never idle the l3_main hwmod so mark the omap_l3_noc node
with ti,no-idle.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 1ec8bdb00183..9a541cd12e0a 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -153,6 +153,7 @@
 		#size-cells = <1>;
 		ranges;
 		ti,hwmods = "l3_main";
+		ti,no-idle;
 		reg = <0x44000000 0x400000
 		       0x44800000 0x400000>;
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.16.1
