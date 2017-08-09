From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  9 Aug 2017 16:56:27 +0800
Subject: [PATCH 4/4] drivers: soc: sunxi: add support for A64 and its SRAM C
In-Reply-To: <20170809085627.32687-1-icenowy@aosc.io>
References: <20170809085627.32687-1-icenowy@aosc.io>
Message-ID: <20170809085627.32687-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64's display engine claims the SRAM C section to work.

Add support for the A64 SRAM controller and the SRAM C section of it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/soc/sunxi/sunxi_sram.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index edc993480020..882be5ed7e84 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -69,6 +69,12 @@ static struct sunxi_sram_desc sun4i_a10_sram_d = {
 				  SUNXI_SRAM_MAP(1, 1, "usb-otg")),
 };
 
+static struct sunxi_sram_desc sun50i_a64_sram_c = {
+	.data	= SUNXI_SRAM_DATA("C", 0x4, 24, 1,
+				  SUNXI_SRAM_MAP(0, 1, "cpu"),
+				  SUNXI_SRAM_MAP(1, 0, "de2")),
+};
+
 static const struct of_device_id sunxi_sram_dt_ids[] = {
 	{
 		.compatible	= "allwinner,sun4i-a10-sram-a3-a4",
@@ -78,6 +84,10 @@ static const struct of_device_id sunxi_sram_dt_ids[] = {
 		.compatible	= "allwinner,sun4i-a10-sram-d",
 		.data		= &sun4i_a10_sram_d.data,
 	},
+	{
+		.compatible	= "allwinner,sun50i-a64-sram-c",
+		.data		= &sun50i_a64_sram_c.data,
+	},
 	{}
 };
 
@@ -295,6 +305,7 @@ static int sunxi_sram_probe(struct platform_device *pdev)
 
 static const struct of_device_id sunxi_sram_dt_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sram-controller" },
+	{ .compatible = "allwinner,sun50i-a64-sram-controller" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
-- 
2.13.0
