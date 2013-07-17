From: Baohua.Song@csr.com (Barry Song)
Date: Wed, 17 Jul 2013 14:12:15 +0800
Subject: [PATCH 2/3] ASoC: hdmi-codec: enable OF support
In-Reply-To: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1374041536-27643-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

this makes users be able to add a hdmi-codec node in dts instead of
hardcoding a platform device in mach.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/soc/codecs/hdmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
index 2bcae2b..78c7b15 100644
--- a/sound/soc/codecs/hdmi.c
+++ b/sound/soc/codecs/hdmi.c
@@ -51,10 +51,21 @@ static int hdmi_codec_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id hdmi_audio_codec_ids[] = {
+	{ .compatible = "hdmi-audio-codec", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, hdmi_audio_codec_ids);
+#endif
+
 static struct platform_driver hdmi_codec_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = hdmi_audio_codec_ids,
+#endif
 	},
 
 	.probe		= hdmi_codec_probe,
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
