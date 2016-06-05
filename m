From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 5 Jun 2016 21:07:16 +0200
Subject: [PATCH] userspace API definitions for auto-focus coil
In-Reply-To: <20160602212746.GT26360@valkosipuli.retiisi.org.uk>
References: <20160524091746.GA14536@amd>
 <20160525212659.GK26360@valkosipuli.retiisi.org.uk>
 <20160527205140.GA26767@amd>
 <20160531212222.GP26360@valkosipuli.retiisi.org.uk>
 <20160531213437.GA28397@amd>
 <20160601152439.GQ26360@valkosipuli.retiisi.org.uk>
 <20160601220840.GA21946@amd>
 <20160602074544.GR26360@valkosipuli.retiisi.org.uk>
 <20160602193027.GB7984@amd>
 <20160602212746.GT26360@valkosipuli.retiisi.org.uk>
Message-ID: <20160605190716.GA11321@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add userspace API definitions.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b6a357a..23011cc 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -974,4 +975,9 @@ enum v4l2_detect_md_mode {
 #define V4L2_CID_DETECT_MD_THRESHOLD_GRID	(V4L2_CID_DETECT_CLASS_BASE + 3)
 #define V4L2_CID_DETECT_MD_REGION_GRID		(V4L2_CID_DETECT_CLASS_BASE + 4)
 
+/* Control IDs specific to the AD5820 driver as defined by V4L2 */
+#define V4L2_CID_FOCUS_AD5820_BASE 	(V4L2_CTRL_CLASS_CAMERA | 0x10af)
+#define V4L2_CID_FOCUS_AD5820_RAMP_TIME	(V4L2_CID_FOCUS_AD5820_BASE+0)
+#define V4L2_CID_FOCUS_AD5820_RAMP_MODE	(V4L2_CID_FOCUS_AD5820_BASE+1)
+
 #endif

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
