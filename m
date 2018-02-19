From: d-gerlach@ti.com (Dave Gerlach)
Date: Sun, 18 Feb 2018 21:35:01 -0600
Subject: [PATCH 5/9] ARM: dts: am33xx: Add pm-sram phandle to soc node
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1519011305-17822-6-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a phandle to point to both the pm-sram-code and pm-sram-data nodes
so that the pm code can locate the sram regions needed to copy low level
PM code.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c27ef2cac394..842e726b944e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -147,6 +147,8 @@
 		mpu {
 			compatible = "ti,omap3-mpu";
 			ti,hwmods = "mpu";
+			pm-sram = <&pm_sram_code
+				   &pm_sram_data>;
 		};
 	};
 
-- 
2.16.1
