From: amit.grover@samsung.com (Amit Grover)
Date: Tue, 04 Feb 2014 15:29:58 +0530
Subject: [PATCH 1/2] [media] v4l2: Add settings for Horizontal and Vertical MV
 Search Range
In-Reply-To: <1391507999-31437-1-git-send-email-amit.grover@samsung.com>
References: <52E0ED10.2020901@samsung.com>
 <1391507999-31437-1-git-send-email-amit.grover@samsung.com>
Message-ID: <1391507999-31437-2-git-send-email-amit.grover@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding V4L2 controls for horizontal and vertical search range in pixels
for motion estimation module in video encoder.

Signed-off-by: Swami Nathan <swaminath.p@samsung.com>
Signed-off-by: Amit Grover <amit.grover@samsung.com>
---
 Documentation/DocBook/media/v4l/controls.xml |   20 ++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls.c         |    6 ++++++
 include/uapi/linux/v4l2-controls.h           |    2 ++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/DocBook/media/v4l/controls.xml b/Documentation/DocBook/media/v4l/controls.xml
index a5a3188..0e1770c 100644
--- a/Documentation/DocBook/media/v4l/controls.xml
+++ b/Documentation/DocBook/media/v4l/controls.xml
@@ -2258,6 +2258,26 @@ Applicable to the MPEG1, MPEG2, MPEG4 encoders.</entry>
 VBV buffer control.</entry>
 	      </row>
 
+		  <row><entry></entry></row>
+	      <row id=""v4l2-mpeg-video-hor-search-range">
+		<entry spanname="id"><constant>V4L2_CID_MPEG_VIDEO_MV_H_SEARCH_RANGE</constant>&nbsp;</entry>
+		<entry>integer</entry>
+	      </row>
+		<row><entry spanname="descr">Horizontal search range defines maximum horizontal search area in pixels
+to search and match for the present Macroblock (MB) in the reference picture. This V4L2 control macro is used to set
+horizontal search range for motion estimation module in video encoder.</entry>
+	      </row>
+
+		 <row><entry></entry></row>
+	      <row id="v4l2-mpeg-video-vert-search-range">
+		<entry spanname="id"><constant>V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE</constant>&nbsp;</entry>
+		<entry>integer</entry>
+	      </row>
+		<row><entry spanname="descr">Vertical search range defines maximum vertical search area in pixels
+to search and match for the present Macroblock (MB) in the reference picture. This V4L2 control macro is used to set
+vertical search range for motion estimation module in video encoder.</entry>
+	      </row>
+
 	      <row><entry></entry></row>
 	      <row>
 		<entry spanname="id"><constant>V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE</constant>&nbsp;</entry>
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 6ff002b..e9e12c4 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -735,6 +735,8 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_DEC_PTS:			return "Video Decoder PTS";
 	case V4L2_CID_MPEG_VIDEO_DEC_FRAME:			return "Video Decoder Frame Count";
 	case V4L2_CID_MPEG_VIDEO_VBV_DELAY:			return "Initial Delay for VBV Control";
+	case V4L2_CID_MPEG_VIDEO_MV_H_SEARCH_RANGE:		return "Horizontal MV Search Range";
+	case V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE:		return "Vertical MV Search Range";
 	case V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER:		return "Repeat Sequence Header";
 
 	/* VPX controls */
@@ -910,6 +912,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		*min = 0;
 		*max = *step = 1;
 		break;
+	case V4L2_CID_MPEG_VIDEO_MV_H_SEARCH_RANGE:
+	case V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE:
+		*type = V4L2_CTRL_TYPE_INTEGER;
+		break;
 	case V4L2_CID_PAN_RESET:
 	case V4L2_CID_TILT_RESET:
 	case V4L2_CID_FLASH_STROBE:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 2cbe605..cda6fa0 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -376,6 +376,8 @@ enum v4l2_mpeg_video_multi_slice_mode {
 #define V4L2_CID_MPEG_VIDEO_DEC_FRAME			(V4L2_CID_MPEG_BASE+224)
 #define V4L2_CID_MPEG_VIDEO_VBV_DELAY			(V4L2_CID_MPEG_BASE+225)
 #define V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER		(V4L2_CID_MPEG_BASE+226)
+#define V4L2_CID_MPEG_VIDEO_MV_H_SEARCH_RANGE		(V4L2_CID_MPEG_BASE+227)
+#define V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE		(V4L2_CID_MPEG_BASE+228)
 
 #define V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP		(V4L2_CID_MPEG_BASE+300)
 #define V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP		(V4L2_CID_MPEG_BASE+301)
-- 
1.7.9.5
