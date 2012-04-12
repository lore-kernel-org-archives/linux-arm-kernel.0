From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Apr 2012 22:12:10 -0300
Subject: [PATCH 2/4] ARM: imx27: Use 'AITC' for the interrupt controller name
In-Reply-To: <1334193132-18944-1-git-send-email-festevam@gmail.com>
References: <1334193132-18944-1-git-send-email-festevam@gmail.com>
Message-ID: <1334193132-18944-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the MX27 Reference Manual the interrupt controller is named AITC:
ARM926EJ-S Interrupt Controller

So use the AITC term instead of AVIC.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27.dtsi |    6 +++---
 arch/arm/mach-imx/imx27-dt.c |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index bc5e7d5..b907277 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -21,8 +21,8 @@
 		serial5 = &uart6;
 	};
 
-	avic: avic-interrupt-controller at e0000000 {
-		compatible = "fsl,imx27-avic", "fsl,avic";
+	aitc: aitc-interrupt-controller at e0000000 {
+		compatible = "fsl,imx27-aitc", "fsl,aitc";
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		reg = <0x10040000 0x1000>;
@@ -42,7 +42,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		interrupt-parent = <&avic>;
+		interrupt-parent = <&aitc>;
 		ranges;
 
 		aipi at 10000000 { /* AIPI1 */
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index ffff10c..51ad447 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -32,7 +32,7 @@ static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
 	{ /* sentinel */ }
 };
 
-static int __init imx27_avic_add_irq_domain(struct device_node *np,
+static int __init imx27_aitc_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
 	irq_domain_add_legacy(np, 64, 0, 0, &irq_domain_simple_ops, NULL);
@@ -52,7 +52,7 @@ static int __init imx27_gpio_add_irq_domain(struct device_node *np,
 }
 
 static const struct of_device_id imx27_irq_match[] __initconst = {
-	{ .compatible = "fsl,imx27-avic", .data = imx27_avic_add_irq_domain, },
+	{ .compatible = "fsl,imx27-aitc", .data = imx27_aitc_add_irq_domain, },
 	{ .compatible = "fsl,imx27-gpio", .data = imx27_gpio_add_irq_domain, },
 	{ /* sentinel */ }
 };
-- 
1.7.1
