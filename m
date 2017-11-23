From: vigneshr@ti.com (Vignesh R)
Date: Thu, 23 Nov 2017 13:21:51 +0530
Subject: [PATCH 3/6] ARM: dts: keystone-k2g: Move ti,
 non-removable property to board dts
In-Reply-To: <20171123075154.3938-1-vigneshr@ti.com>
References: <20171123075154.3938-1-vigneshr@ti.com>
Message-ID: <20171123075154.3938-4-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 66AK2G EVM mmc1 is connected to emmc whereas 66AK2G ICE baord has SD
card slot connected to mmc1. Therefore move emmc specific
ti,non-removable property from SoC file to EVM's dts file.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 1 +
 arch/arm/boot/dts/keystone-k2g.dtsi    | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 298a50555e46..03b3e7c5dc8e 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -127,6 +127,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vcc3v3_dcin_reg>; /* VCC3V3_EMMC is connected to VCC3V3_DCIN */
+	ti,non-removable;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 01d29320b04c..ef82c0a6e607 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -372,7 +372,6 @@
 			dma-names = "tx", "rx";
 			bus-width = <8>;
 			ti,needs-special-reset;
-			ti,non-removable;
 			max-frequency = <96000000>;
 			power-domains = <&k2g_pds 0xc>;
 			clocks = <&k2g_clks 0xc 1>, <&k2g_clks 0xc 2>;
-- 
2.15.0
