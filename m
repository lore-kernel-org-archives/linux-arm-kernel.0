From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 20 Aug 2017 17:53:28 +0200
Subject: [PATCH 2/2] soc/fsl/qe: Slighly simplify code
Message-ID: <20170820155328.882-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return 0 instead of 'ret' (which is 0 at this point) to make the code more
explicit.
Also avoid a useless initialization of 'ret'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/soc/fsl/qe/qe_tdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index 6b9647fee512..c90c72ca9e3e 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -42,7 +42,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 		     struct ucc_tdm_info *ut_info)
 {
 	const char *sprop;
-	int ret = 0;
+	int ret;
 	u32 val;
 	struct resource *res;
 	struct device_node *np2;
@@ -171,7 +171,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 		siram_init_flag = 1;
 	}
 
-	return ret;
+	return 0;
 
 err_miss_siram_property:
 	return ret;
-- 
2.11.0
