From: d-gerlach@ti.com (Dave Gerlach)
Date: Sun, 18 Feb 2018 21:35:04 -0600
Subject: [PATCH 8/9] ARM: dts: am4372: Mark emif with ti,no-idle
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1519011305-17822-9-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can never idle the emif hwmod from within the HLOS so mark the emif
node with ti,no-idle.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index b136c401879f..1ec8bdb00183 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -247,6 +247,7 @@
 			compatible = "ti,emif-am4372";
 			reg = <0x4c000000 0x1000000>;
 			ti,hwmods = "emif";
+			ti,no-idle;
 			sram = <&pm_sram_code
 				&pm_sram_data>;
 		};
-- 
2.16.1
