From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 19 Nov 2012 15:46:36 +0100
Subject: [PATCH 4/4] ARM: dts: exynos4210-origen: Add vmmc fixed voltage
 regulator
In-Reply-To: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
References: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
Message-ID: <1353336396-21161-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds fixed voltage vmmc regulator to dts file of Origen
board.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 5395875..62f278e 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -32,10 +32,20 @@
 		bootargs ="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
 	};
 
+	mmc_reg: voltage-regulator {
+	        compatible = "regulator-fixed";
+		regulator-name = "VMEM_VDD_2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpx1 1 0>;
+		enable-active-high;
+	};
+
 	sdhci at 12530000 {
 		bus-width = <4>;
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
 		pinctrl-names = "default";
+		vmmc-supply = <&mmc_reg>;
 		status = "okay";
 	};
 
@@ -43,6 +53,7 @@
 		bus-width = <4>;
 		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;
 		pinctrl-names = "default";
+		vmmc-supply = <&mmc_reg>;
 		status = "okay";
 	};
 
-- 
1.8.0
