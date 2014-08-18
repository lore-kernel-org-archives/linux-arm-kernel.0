From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 18 Aug 2014 16:49:20 +0800
Subject: [PATCH 1/6] pinctrl: sirf: fix "quoted string split across lines"
Message-ID: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bin Shi <Bin.Shi@csr.com>

this patch fixes:
WARNING: quoted string split across lines
902: FILE: drivers/pinctrl/sirf/pinctrl-sirf.c:902:
+MODULE_AUTHOR("Rongjun Ying <rongjun.ying@csr.com>, "
+	"Yuping Luo <yuping.luo@csr.com>, "

WARNING: quoted string split across lines
903: FILE: drivers/pinctrl/sirf/pinctrl-sirf.c:903:
+	"Yuping Luo <yuping.luo@csr.com>, "
+	"Barry Song <baohua.song@csr.com>");

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 4c1d7c6..08d1f5a9 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -898,8 +898,8 @@ static int __init sirfsoc_gpio_init(void)
 }
 subsys_initcall(sirfsoc_gpio_init);
 
-MODULE_AUTHOR("Rongjun Ying <rongjun.ying@csr.com>, "
-	"Yuping Luo <yuping.luo@csr.com>, "
-	"Barry Song <baohua.song@csr.com>");
+MODULE_AUTHOR("Rongjun Ying <rongjun.ying@csr.com>");
+MODULE_AUTHOR("Yuping Luo <yuping.luo@csr.com>");
+MODULE_AUTHOR("Barry Song <baohua.song@csr.com>");
 MODULE_DESCRIPTION("SIRFSOC pin control driver");
 MODULE_LICENSE("GPL");
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
