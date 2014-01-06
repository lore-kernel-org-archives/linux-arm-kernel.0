From: satish.patel@ti.com (Satish Patel)
Date: Mon, 6 Jan 2014 17:37:41 +0530
Subject: [RFC PATCH v1 4/5] ARM: dts: AM43xx: DT entries added for ti-usim
In-Reply-To: <1389010062-17185-1-git-send-email-satish.patel@ti.com>
References: <1389010062-17185-1-git-send-email-satish.patel@ti.com>
Message-ID: <1389010062-17185-5-git-send-email-satish.patel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoC specific DT entries added for TI's USIM - smart card controller of AM43xx
platfrom.

Signed-off-by: Satish Patel <satish.patel@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index fc220a4..cc47aff 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -1071,6 +1071,17 @@
 			clocks = <&mcasp1_fck>;
 			clock-names = "fck";
 		};
+
+		usim0: usim at 48034000 {
+			compatible = "ti,usim";
+			reg = <0x48034000 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "usim0";
+			clocks = <&usim0_opt_fck>, <&usim0_opt_fck32>;
+			clock-names = "opt_fck", "opt_fck32";
+			status = "disabled";
+		};
+
 	};
 
 	clocks {
-- 
1.7.1
