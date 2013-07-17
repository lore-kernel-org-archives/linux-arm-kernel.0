From: Baohua.Song@csr.com (Barry Song)
Date: Wed, 17 Jul 2013 14:12:14 +0800
Subject: [PATCH 1/3] ASoC: bt-sco: enable OF support
Message-ID: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

this makes users be able to add a bt-sco node in dts instead of
hardcoding a platform device in mach.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/soc/codecs/bt-sco.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index a081d9f..39e7ebe 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -46,6 +46,14 @@ static int bt_sco_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id bt_sco_of_match[] = {
+	{ .compatible = "bt-sco-codec", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bt_sco_of_match);
+#endif
+
 static struct platform_device_id bt_sco_driver_ids[] = {
 	{
 		.name		= "dfbmcs320",
@@ -58,6 +66,9 @@ static struct platform_driver bt_sco_driver = {
 	.driver = {
 		.name = "bt-sco",
 		.owner = THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = bt_sco_of_match,
+#endif
 	},
 	.probe = bt_sco_probe,
 	.remove = bt_sco_remove,
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
