From: jtzhou@marvell.com (Jett.Zhou)
Date: Sun, 9 Jun 2013 16:44:46 +0800
Subject: [V1 5/7] video: mmp: add pitch info in mmp_win structure
Message-ID: <1370767486-11729-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jing Xiang <jxiang@marvell.com>

Add pitch length info of graphics/video layer for mmp_win, if it is
YUV format of video layer, u/v pitch will non-zero.

Signed-off-by: Jing Xiang <jxiang@marvell.com>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 include/video/mmp_disp.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
index b9dd1fb..5708d26 100644
--- a/include/video/mmp_disp.h
+++ b/include/video/mmp_disp.h
@@ -91,6 +91,9 @@ struct mmp_win {
 	u16	up_crop;
 	u16	bottom_crop;
 	int	pix_fmt;
+	/* pitch[0]: graphics/video layer line length or y pitch
+	 * pitch[1]/pitch[2]: video u/v pitch if non-zero */
+	u32	pitch[3];
 };
 
 struct mmp_addr {
-- 
1.7.0.4
