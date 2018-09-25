From: qader.aymen@gmail.com (Aymen Qader)
Date: Tue, 25 Sep 2018 09:33:59 +0100
Subject: [PATCH v3 1/2] staging: bcm2835-camera: Update TODO
In-Reply-To: <20180925083401.22533-1-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
Message-ID: <20180925083401.22533-5-qader.aymen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the TODO item to remove manual cache flushing from bulk_receive.
This was previously done in this commit:

commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
flush operations")

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/TODO | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
index cefce72d814f..6c2b4ffe4996 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/TODO
+++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
@@ -15,9 +15,3 @@ padding in the V4L2 spec, but that padding doesn't match what the
 hardware can do.  If we exposed the native padding requirements
 through the V4L2 "multiplanar" formats, the firmware would have one
 less copy it needed to do.
-
-3) Port to ARM64
-
-The bulk_receive() does some manual cache flushing that are 32-bit ARM
-only, which we should convert to proper cross-platform APIs.
-
-- 
2.17.1
