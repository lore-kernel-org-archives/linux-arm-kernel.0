From: denis@eukrea.com (Denis Carikli)
Date: Thu,  6 Mar 2014 17:01:40 +0100
Subject: [PATCH v9][ 1/8] [media] v4l2: add new V4L2_PIX_FMT_RGB666 pixel
 format.
Message-ID: <1394121702-13257-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That new macro is needed by the imx_drm staging driver
  for supporting the QVGA display of the eukrea-cpuimx51 board.

Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
ChangeLog v8->v9:
- Removed the Cc. They are now set in git-send-email directly.

ChangeLog v7->v8:
- Added Mauro Carvalho Chehab back to the list of Cc

ChangeLog v6->v7:
- Shrinked even more the Cc list.
ChangeLog v5->v6:
- Remove people not concerned by this patch from the Cc list.

ChangeLog v3->v4:
- Added Laurent Pinchart's Ack.

ChangeLog v2->v3:
- Added some interested people in the Cc list.
- Added Mauro Carvalho Chehab's Ack.
- Added documentation.
---
 .../DocBook/media/v4l/pixfmt-packed-rgb.xml        |   78 ++++++++++++++++++++
 include/uapi/linux/videodev2.h                     |    1 +
 2 files changed, 79 insertions(+)

diff --git a/Documentation/DocBook/media/v4l/pixfmt-packed-rgb.xml b/Documentation/DocBook/media/v4l/pixfmt-packed-rgb.xml
index 166c8d6..f6a3e84 100644
--- a/Documentation/DocBook/media/v4l/pixfmt-packed-rgb.xml
+++ b/Documentation/DocBook/media/v4l/pixfmt-packed-rgb.xml
@@ -279,6 +279,45 @@ colorspace <constant>V4L2_COLORSPACE_SRGB</constant>.</para>
 	    <entry></entry>
 	    <entry></entry>
 	  </row>
+	  <row id="V4L2-PIX-FMT-RGB666">
+	    <entry><constant>V4L2_PIX_FMT_RGB666</constant></entry>
+	    <entry>'RGBH'</entry>
+	    <entry></entry>
+	    <entry>r<subscript>5</subscript></entry>
+	    <entry>r<subscript>4</subscript></entry>
+	    <entry>r<subscript>3</subscript></entry>
+	    <entry>r<subscript>2</subscript></entry>
+	    <entry>r<subscript>1</subscript></entry>
+	    <entry>r<subscript>0</subscript></entry>
+	    <entry>g<subscript>5</subscript></entry>
+	    <entry>g<subscript>4</subscript></entry>
+	    <entry></entry>
+	    <entry>g<subscript>3</subscript></entry>
+	    <entry>g<subscript>2</subscript></entry>
+	    <entry>g<subscript>1</subscript></entry>
+	    <entry>g<subscript>0</subscript></entry>
+	    <entry>b<subscript>5</subscript></entry>
+	    <entry>b<subscript>4</subscript></entry>
+	    <entry>b<subscript>3</subscript></entry>
+	    <entry>b<subscript>2</subscript></entry>
+	    <entry></entry>
+	    <entry>b<subscript>1</subscript></entry>
+	    <entry>b<subscript>0</subscript></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	  </row>
 	  <row id="V4L2-PIX-FMT-BGR24">
 	    <entry><constant>V4L2_PIX_FMT_BGR24</constant></entry>
 	    <entry>'BGR3'</entry>
@@ -781,6 +820,45 @@ defined in error. Drivers may interpret them as in <xref
 	    <entry></entry>
 	    <entry></entry>
 	  </row>
+	  <row><!-- id="V4L2-PIX-FMT-RGB666" -->
+	    <entry><constant>V4L2_PIX_FMT_RGB666</constant></entry>
+	    <entry>'RGBH'</entry>
+	    <entry></entry>
+	    <entry>r<subscript>5</subscript></entry>
+	    <entry>r<subscript>4</subscript></entry>
+	    <entry>r<subscript>3</subscript></entry>
+	    <entry>r<subscript>2</subscript></entry>
+	    <entry>r<subscript>1</subscript></entry>
+	    <entry>r<subscript>0</subscript></entry>
+	    <entry>g<subscript>5</subscript></entry>
+	    <entry>g<subscript>4</subscript></entry>
+	    <entry></entry>
+	    <entry>g<subscript>3</subscript></entry>
+	    <entry>g<subscript>2</subscript></entry>
+	    <entry>g<subscript>1</subscript></entry>
+	    <entry>g<subscript>0</subscript></entry>
+	    <entry>b<subscript>5</subscript></entry>
+	    <entry>b<subscript>4</subscript></entry>
+	    <entry>b<subscript>3</subscript></entry>
+	    <entry>b<subscript>2</subscript></entry>
+	    <entry></entry>
+	    <entry>b<subscript>1</subscript></entry>
+	    <entry>b<subscript>0</subscript></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	    <entry></entry>
+	  </row>
 	  <row><!-- id="V4L2-PIX-FMT-BGR24" -->
 	    <entry><constant>V4L2_PIX_FMT_BGR24</constant></entry>
 	    <entry>'BGR3'</entry>
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 6ae7bbe..3051d67 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -294,6 +294,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_RGB555X v4l2_fourcc('R', 'G', 'B', 'Q') /* 16  RGB-5-5-5 BE  */
 #define V4L2_PIX_FMT_RGB565X v4l2_fourcc('R', 'G', 'B', 'R') /* 16  RGB-5-6-5 BE  */
 #define V4L2_PIX_FMT_BGR666  v4l2_fourcc('B', 'G', 'R', 'H') /* 18  BGR-6-6-6	  */
+#define V4L2_PIX_FMT_RGB666  v4l2_fourcc('R', 'G', 'B', 'H') /* 18  RGB-6-6-6	  */
 #define V4L2_PIX_FMT_BGR24   v4l2_fourcc('B', 'G', 'R', '3') /* 24  BGR-8-8-8     */
 #define V4L2_PIX_FMT_RGB24   v4l2_fourcc('R', 'G', 'B', '3') /* 24  RGB-8-8-8     */
 #define V4L2_PIX_FMT_BGR32   v4l2_fourcc('B', 'G', 'R', '4') /* 32  BGR-8-8-8-8   */
-- 
1.7.9.5
