From: yocto6@gmail.com (Nicholas Krause)
Date: Sat, 27 Sep 2014 22:50:52 -0400
Subject: [PATCH] arm: Remove read of issue in sa1111.c in sa1111_resume
Message-ID: <1411872652-16207-1-git-send-email-yocto6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the FIXME message and issue with reading in this driver before resuming
in the function, sa1111_resume.

Signed-off-by: Nicholas Krause <yocto6@gmail.com>
---
 arch/arm/common/sa1111.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index e57d7e5..0c4b9a9 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -950,9 +950,7 @@ static int sa1111_resume(struct platform_device *dev)
 
 	/*
 	 * Ensure that the SA1111 is still here.
-	 * FIXME: shouldn't do this here.
 	 */
-	id = sa1111_readl(sachip->base + SA1111_SKID);
 	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
 		__sa1111_remove(sachip);
 		platform_set_drvdata(dev, NULL);
-- 
1.9.1
