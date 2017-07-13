From: lionel.debieve@st.com (Lionel Debieve)
Date: Thu, 13 Jul 2017 15:06:32 +0200
Subject: [PATCH 2/3] crypto: stm32 - solve crc issue during unbind
In-Reply-To: <cover.1499950409.git.lionel.debieve@st.com>
References: <cover.1499950409.git.lionel.debieve@st.com>
Message-ID: <cb1e49d9cbdfe43ea2243ed8aa95d11f18813042.1499950409.git.lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the correct unregister_shashes function to
to remove the registered algo

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/crypto/stm32/stm32_crc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32_crc32.c b/drivers/crypto/stm32/stm32_crc32.c
index 04d2f4b..090582b 100644
--- a/drivers/crypto/stm32/stm32_crc32.c
+++ b/drivers/crypto/stm32/stm32_crc32.c
@@ -296,7 +296,7 @@ static int stm32_crc_remove(struct platform_device *pdev)
 	list_del(&crc->list);
 	spin_unlock(&crc_list.lock);
 
-	crypto_unregister_shash(algs);
+	crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
 
 	clk_disable_unprepare(crc->clk);
 
-- 
2.7.4
