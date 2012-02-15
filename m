From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 15 Feb 2012 18:37:35 +0100
Subject: [PATCH 2/4] arm/dts: OMAP4: Add SPI controller nodes
In-Reply-To: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
References: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
Message-ID: <1329327457-2121-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 4 McSPI controller nodes present in an OMAP4 device.

Remove SPI static device initialisation if DT is populated.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap4.dtsi  |   32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c |    4 +++-
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4b81f03..7fc0cbe 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -209,5 +209,37 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
 		};
+
+		mcspi1: mcspi at 1 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi1";
+			ti,spi-num-cs = <4>;
+		};
+
+		mcspi2: mcspi at 2 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi2";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi3: mcspi at 3 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi3";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi4: mcspi at 4 {
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
