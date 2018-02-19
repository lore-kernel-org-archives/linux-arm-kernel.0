From: d-gerlach@ti.com (Dave Gerlach)
Date: Sun, 18 Feb 2018 21:35:03 -0600
Subject: [PATCH 7/9] ARM: dts: am33xx: Mark emif with ti,no-idle
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1519011305-17822-8-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can never idle the emif hwmod from within the HLOS so mark the emif
node with ti,no-idle.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 842e726b944e..77c618829734 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -964,6 +964,7 @@
 			ti,hwmods = "emif";
 			sram = <&pm_sram_code
 				&pm_sram_data>;
+			ti,no-idle;
 		};
 
 		gpmc: gpmc at 50000000 {
-- 
2.16.1
