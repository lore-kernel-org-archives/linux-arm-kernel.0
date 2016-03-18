From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Mar 2016 15:25:37 +0100
Subject: [PATCH v3 5/5] dmaengine: sun6i: Compact a bit some config constants
In-Reply-To: <cover.1458311540.git.moinejf@free.fr>
References: <cover.1458311540.git.moinejf@free.fr>
Message-ID: <290511bc7939facf8d7340ae1c48f8a91a9e47c4.1458311540.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All config SoC specific values are less than 128. Store them as bytes.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 643ba4c..491522d 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -98,10 +98,10 @@
  * to a certain compatible string.
  */
 struct sun6i_dma_config {
-	u32 nr_max_channels;
-	u32 nr_max_requests;
-	u32 nr_max_vchans;
-	u32 burst_4;
+	u8 nr_max_channels;
+	u8 nr_max_requests;
+	u8 nr_max_vchans;
+	u8 burst_4;
 };
 
 /*
-- 
2.7.4
