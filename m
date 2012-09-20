From: mporter@ti.com (Matt Porter)
Date: Thu, 20 Sep 2012 10:43:46 -0400
Subject: [RFC PATCH 13/13] Documentation: add schedule for removing private
 EDMA API
In-Reply-To: <1348152226-13588-1-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
Message-ID: <1348152226-13588-14-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci-pcm driver is the last in-kernel user of the private
EDMA API. Once it has been converted to DMA Engine API the
private EDMA API functionality can be folded into the EDMA DMA
Engine driver and removed.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 Documentation/feature-removal-schedule.txt |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index f4d8c71..64109e6 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -637,3 +637,13 @@ Who:	Russell King <linux@arm.linux.org.uk>,
 	Santosh Shilimkar <santosh.shilimkar@ti.com>
 
 ----------------------------
+
+What:	EDMA private DMA implementation
+When:	2013
+Why:	We have a DMA engine implementation; all users should be updated
+	to use this rather than persisting with the old APIs.  The old APIs
+	block merging the old DMA engine implementation into the DMA
+	engine driver.
+Who:	Matt Porter <mporter@ti.com>
+
+----------------------------
-- 
1.7.9.5
