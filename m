From: d-gerlach@ti.com (Dave Gerlach)
Date: Sun, 18 Feb 2018 21:35:00 -0600
Subject: [PATCH 4/9] ARM: dts: am4372: Update emif node
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1519011305-17822-5-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we will use ti-emif-sram driver for am4372 PM, update the
emif DT node with the required sram property.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 81a03c1ad770..10dc52a07b32 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -237,6 +237,8 @@
 			compatible = "ti,emif-am4372";
 			reg = <0x4c000000 0x1000000>;
 			ti,hwmods = "emif";
+			sram = <&pm_sram_code
+				&pm_sram_data>;
 		};
 
 		edma: edma at 49000000 {
-- 
2.16.1
