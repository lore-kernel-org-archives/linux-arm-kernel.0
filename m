From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu,  9 Mar 2017 20:52:56 -0800
Subject: [PATCH v5 16/39] [media] v4l2: add a new-frame before end-of-frame
 event
In-Reply-To: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1489121599-23206-17-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a NEW_FRAME_BEFORE_EOF event to signal that a video capture or
output device has signaled a new frame is ready before a previous
frame has completed reception or transmission. This usually indicates
a DMA read/write channel is having trouble gaining bus access.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 Documentation/media/uapi/v4l/vidioc-dqevent.rst | 6 ++++++
 Documentation/media/videodev2.h.rst.exceptions  | 1 +
 include/uapi/linux/videodev2.h                  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
index dc77363..54bc7ae 100644
--- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
+++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
@@ -203,6 +203,12 @@ call.
 	has measured an interval between the reception or transmit
 	completion of two consecutive frames of video that is outside
 	the nominal frame interval by some tolerance value.
+    * - ``V4L2_EVENT_NEW_FRAME_BEFORE_EOF``
+      - 8
+      - This event is triggered when the video capture or output device
+	has signaled a new frame is ready before a previous frame has
+	completed reception or transmission. This usually indicates a
+	DMA read/write channel is having trouble gaining bus access.
     * - ``V4L2_EVENT_PRIVATE_START``
       - 0x08000000
       - Base event number for driver-private events.
diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentation/media/videodev2.h.rst.exceptions
index c7d8fad..be6f332 100644
--- a/Documentation/media/videodev2.h.rst.exceptions
+++ b/Documentation/media/videodev2.h.rst.exceptions
@@ -460,6 +460,7 @@ replace define V4L2_EVENT_FRAME_SYNC event-type
 replace define V4L2_EVENT_SOURCE_CHANGE event-type
 replace define V4L2_EVENT_MOTION_DET event-type
 replace define V4L2_EVENT_FRAME_INTERVAL_ERROR event-type
+replace define V4L2_EVENT_NEW_FRAME_BEFORE_EOF event-type
 replace define V4L2_EVENT_PRIVATE_START event-type
 
 replace define V4L2_EVENT_CTRL_CH_VALUE ctrl-changes-flags
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index cf5a0d0..f54a82a 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2132,6 +2132,7 @@ struct v4l2_streamparm {
 #define V4L2_EVENT_SOURCE_CHANGE		5
 #define V4L2_EVENT_MOTION_DET			6
 #define V4L2_EVENT_FRAME_INTERVAL_ERROR		7
+#define V4L2_EVENT_NEW_FRAME_BEFORE_EOF		8
 #define V4L2_EVENT_PRIVATE_START		0x08000000
 
 /* Payload for V4L2_EVENT_VSYNC */
-- 
2.7.4
