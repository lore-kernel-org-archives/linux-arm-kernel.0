From: d-gerlach@ti.com (Dave Gerlach)
Date: Sun, 18 Feb 2018 21:34:59 -0600
Subject: [PATCH 3/9] ARM: dts: am33xx: Update emif node
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1519011305-17822-4-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we will use ti-emif-sram driver for am335x PM, update the
emif DT node with the required sram property.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index a9bbf68db077..c27ef2cac394 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -960,6 +960,8 @@
 			compatible = "ti,emif-am3352";
 			reg = <0x4c000000 0x1000000>;
 			ti,hwmods = "emif";
+			sram = <&pm_sram_code
+				&pm_sram_data>;
 		};
 
 		gpmc: gpmc at 50000000 {
-- 
2.16.1
