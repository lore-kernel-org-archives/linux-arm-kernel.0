From: colin.king@canonical.com (Colin King)
Date: Fri, 23 Feb 2018 12:41:17 +0000
Subject: [PATCH] ASoC: sirf: remove duplicated bit-wise or of
 USP_RXFIFO_THD_INT
Message-ID: <20180223124117.24686-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Bit pattern USP_RXFIFO_THD_INT is being bit-wise or'd twice;
remove the redundant 2nd USP_RXFIFO_THD_INT

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sirf/sirf-usp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sirf/sirf-usp.h b/sound/soc/sirf/sirf-usp.h
index bf0201cb15bc..e22e13a619e8 100644
--- a/sound/soc/sirf/sirf-usp.h
+++ b/sound/soc/sirf/sirf-usp.h
@@ -154,7 +154,7 @@
 					USP_RX_IO_DMA_INT|\
 					USP_RXFIFO_FULL_INT|\
 					USP_RXFIFO_THD_INT|\
-					USP_RXFIFO_THD_INT|USP_RX_TIMEOUT_INT)
+					USP_RX_TIMEOUT_INT)
 
 #define USP_INT_ALL        0x1FFF
 
-- 
2.15.1
