From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 27 Jun 2017 17:41:22 +0300
Subject: [PATCH v2 02/15] staging: fsl-mc: be consistent when checking
 strcmp() return
In-Reply-To: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
References: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
Message-ID: <20170627144135.15599-3-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Stick to one way of checking the return code of strcmp(): use '!'.
This was suggested in a review comment.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v2:
 - new patch

 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
index 9291847..d34e2ff 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
@@ -19,9 +19,9 @@
 
 static bool __must_check fsl_mc_is_allocatable(const char *obj_type)
 {
-	return strcmp(obj_type, "dpbp") == 0 ||
-	       strcmp(obj_type, "dpmcp") == 0 ||
-	       strcmp(obj_type, "dpcon") == 0;
+	return strcmp(obj_type, "dpbp") ||
+	       strcmp(obj_type, "dpmcp") ||
+	       strcmp(obj_type, "dpcon");
 }
 
 /**
-- 
2.9.4
