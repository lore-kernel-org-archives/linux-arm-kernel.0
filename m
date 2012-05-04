From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 4 May 2012 20:12:19 +0800
Subject: [PATCH v2 5/5] ARM: mx28evk: add mxs-dma dt support
In-Reply-To: <1336133539-13465-1-git-send-email-b29396@freescale.com>
References: <1336133539-13465-1-git-send-email-b29396@freescale.com>
Message-ID: <1336133539-13465-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Huang Shijie <b32955@freescale.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/boot/dts/imx28.dtsi   |    4 ++--
 arch/arm/mach-mxs/clock-mx28.c |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index d1f4f8c..5f61777 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -52,8 +52,8 @@
 			};
 
 			dma-apbh at 80004000 {
+				compatible = "fsl,imx28-dma-apbh";
 				reg = <0x80004000 2000>;
-				status = "disabled";
 			};
 
 			perfmon at 80006000 {
@@ -115,8 +115,8 @@
 			};
 
 			dma-apbx at 80024000 {
+				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 2000>;
-				status = "disabled";
 			};
 
 			dcp at 80028000 {
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index cca2cf7..9c926b6 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -652,6 +652,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("80074000.serial", NULL, uart_clk)
 	_REGISTER_CLOCK("800f0000.ethernet", NULL, fec_clk)
 	_REGISTER_CLOCK("800f4000.ethernet", NULL, fec_clk)
+	_REGISTER_CLOCK("80004000.dma-apbh", NULL, hbus_clk)
+	_REGISTER_CLOCK("80024000.dma-apbx", NULL, xbus_clk)
 };
 
 static int clk_misc_init(void)
-- 
1.7.0.4
