From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 10 Mar 2016 10:56:52 +0100
Subject: [PATCH 3/5] dmaengine: sun6i: Add 4 as a possible bust value
In-Reply-To: <cover.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
Message-ID: <63a8e05126c45e3064dbe83947fc34459a2d4a02.1457606136.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some DMA transfers, as for H3 audio, ask for 4 as a bust value.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 3579ee7..7c98c0d 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -238,6 +238,8 @@ static inline s8 convert_burst(u32 maxburst)
 	switch (maxburst) {
 	case 1:
 		return 0;
+	case 4:
+		return 1;
 	case 8:
 		return 2;
 	default:
-- 
2.7.2
