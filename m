From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 30 Jun 2015 15:04:54 +0300
Subject: [PATCH] ARM: dts: am4372.dtsi: disable rfbi
Message-ID: <1435665894-28491-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When DSS nodes were added to am4372.dtsi, the rfbi node was not marked
as disabled. This should have been done, as the rule of thumb is to
disable all DSS nodes that are not used, and especially rfbi, as we
don't have a driver for rfbi.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c80a3e233792..75831e556741 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -941,6 +941,7 @@
 				ti,hwmods = "dss_rfbi";
 				clocks = <&disp_clk>;
 				clock-names = "fck";
+				status = "disabled";
 			};
 		};
 
-- 
2.1.4
