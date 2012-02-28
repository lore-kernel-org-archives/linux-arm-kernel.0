From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 28 Feb 2012 23:19:08 +0100
Subject: [PATCH v2 3/5] arm/dts: OMAP4: Add SPI controller nodes
In-Reply-To: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
References: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
Message-ID: <1330467550-20474-4-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 4 McSPI controller nodes present in an OMAP4 device.

Remove SPI static device initialisation if DT is populated.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap4.dtsi  |   32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c |    4 +++-
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index e8fe75f..82830f5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -127,5 +127,37 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
+
+		mcspi1: spi at 48098000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi1";
+			ti,spi-num-cs = <4>;
+		};
+
+		mcspi2: spi at 4809a000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi2";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi3: spi at 480b8000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi3";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi4: spi at 480ba000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi4";
+			ti,spi-num-cs = <1>;
+		};
 	};
 };
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 283d11e..8a489ba 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -725,7 +725,9 @@ static int __init omap2_init_devices(void)
 	omap_init_dmic();
 	omap_init_camera();
 	omap_init_mbox();
-	omap_init_mcspi();
+	/* If dtb is there, the devices will be created dynamically */
+	if (!of_have_populated_dt())
+		omap_init_mcspi();
 	omap_init_pmu();
 	omap_hdq_init();
 	omap_init_sti();
-- 
1.7.0.4
