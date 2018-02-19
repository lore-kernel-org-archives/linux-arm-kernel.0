From: d-gerlach@ti.com (Dave Gerlach)
Date: Sun, 18 Feb 2018 21:35:02 -0600
Subject: [PATCH 6/9] ARM: dts: am4372: Add soc node
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1519011305-17822-7-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add soc node for am4372 with pm-sram phandle to both pm-sram-code and
pm-sram-data regions.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 10dc52a07b32..b136c401879f 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -92,6 +92,16 @@
 		};
 	};
 
+	soc {
+		compatible = "ti,omap-infra";
+		mpu {
+			compatible = "ti,omap4-mpu";
+			ti,hwmods = "mpu";
+			pm-sram = <&pm_sram_code
+				   &pm_sram_data>;
+		};
+	};
+
 	gic: interrupt-controller at 48241000 {
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
-- 
2.16.1
