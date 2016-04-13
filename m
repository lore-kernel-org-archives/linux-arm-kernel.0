From: david@lechnology.com (David Lechner)
Date: Wed, 13 Apr 2016 17:30:26 -0500
Subject: [PATCH 1/3] ARM: DTS: da850: add node for spi0
In-Reply-To: <1460586628-25152-1-git-send-email-david@lechnology.com>
References: <1460586628-25152-1-git-send-email-david@lechnology.com>
Message-ID: <1460586628-25152-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds device definition for soc spi0 and also a aux data that is needed
for clock matching.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi     | 10 ++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index bbe7dd6..92b5f3c 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -295,6 +295,16 @@
 			reg = <0x308000 0x80>;
 			status = "disabled";
 		};
+		spi0: spi at 41000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "ti,da830-spi";
+			reg = <0x41000 0x1000>;
+			num-cs = <6>;
+			ti,davinci-spi-intr-line = <1>;
+			interrupts = <20>;
+			status = "disabled";
+		};
 		spi1: spi at 30e000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 64f3887..754f478 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -28,6 +28,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f06000, "ecap", NULL),
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f07000, "ecap", NULL),
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f08000, "ecap", NULL),
+	OF_DEV_AUXDATA("ti,da830-spi", 0x01c41000, "spi_davinci.0", NULL),
 	OF_DEV_AUXDATA("ti,da830-spi", 0x01f0e000, "spi_davinci.1", NULL),
 	OF_DEV_AUXDATA("ns16550a", 0x01c42000, "serial8250.0", NULL),
 	OF_DEV_AUXDATA("ns16550a", 0x01d0c000, "serial8250.1", NULL),
-- 
1.9.1
