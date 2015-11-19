From: songjun.wu@atmel.com (Songjun Wu)
Date: Thu, 19 Nov 2015 11:26:30 +0800
Subject: [PATCH] ASoC: Atmel: ClassD: Set GCK's parent clock
Message-ID: <1447903590-3285-1-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set GCK's parent clock as audio clock, make
sure the GCK's parent clock is audio clock.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

 sound/soc/atmel/atmel-classd.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 8276675..2f5190b 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -588,6 +588,12 @@ static int atmel_classd_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = clk_set_parent(dd->gclk, dd->aclk);
+	if (ret) {
+		dev_err(dev, "failed to set GCK parent clock: %d\n", ret);
+		return ret;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "no memory resource\n");
-- 
1.7.9.5
