From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Fri, 17 Mar 2017 15:08:22 +0100
Subject: [PATCH v3 09/11] ASoC: codec: add DT support in dmic codec
In-Reply-To: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <1489759704-30217-10-git-send-email-arnaud.pouliquen@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of_table to allows DT probing.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/codecs/dmic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index c82b9dc..d04cac9 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -73,9 +73,17 @@ static int dmic_dev_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:dmic-codec");
 
+static const struct of_device_id dmic_dev_match[] = {
+	{
+		.compatible = "dmic-codec",
+	},
+	{},
+};
+
 static struct platform_driver dmic_driver = {
 	.driver = {
 		.name = "dmic-codec",
+		.of_match_table = dmic_dev_match,
 	},
 	.probe = dmic_dev_probe,
 	.remove = dmic_dev_remove,
-- 
1.9.1
