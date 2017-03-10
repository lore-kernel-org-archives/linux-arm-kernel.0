From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu,  9 Mar 2017 20:52:55 -0800
Subject: [PATCH v5 15/39] [media] v4l2: add a frame interval error event
In-Reply-To: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1489121599-23206-16-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new FRAME_INTERVAL_ERROR event to signal that a video capture or
output device has measured an interval between the reception or transmit
completion of two consecutive frames of video that is outside the nominal
frame interval by some tolerance value.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 Documentation/media/uapi/v4l/vidioc-dqevent.rst | 6 ++++++
 Documentation/media/videodev2.h.rst.exceptions  | 1 +
 include/uapi/linux/videodev2.h                  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
index 8d663a7..dc77363 100644
--- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
+++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
@@ -197,6 +197,12 @@ call.
 	the regions changes. This event has a struct
 	:c:type:`v4l2_event_motion_det`
 	associated with it.
+    * - ``V4L2_EVENT_FRAME_INTERVAL_ERROR``
+      - 7
+      - This event is triggered when the video capture or output device
+	has measured an interval between the reception or transmit
+	completion of two consecutive frames of video that is outside
+	the nominal frame interval by some tolerance value.
     * - ``V4L2_EVENT_PRIVATE_START``
       - 0x08000000
       - Base event number for driver-private events.
diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentation/media/videodev2.h.rst.exceptions
index e11a0d0..c7d8fad 100644
--- a/Documentation/media/videodev2.h.rst.exceptions
+++ b/Documentation/media/videodev2.h.rst.exceptions
@@ -459,6 +459,7 @@ replace define V4L2_EVENT_CTRL event-type
 replace define V4L2_EVENT_FRAME_SYNC event-type
 replace define V4L2_EVENT_SOURCE_CHANGE event-type
 replace define V4L2_EVENT_MOTION_DET event-type
+replace define V4L2_EVENT_FRAME_INTERVAL_ERROR event-type
 replace define V4L2_EVENT_PRIVATE_START event-type
 
 replace define V4L2_EVENT_CTRL_CH_VALUE ctrl-changes-flags
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 45184a2..cf5a0d0 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2131,6 +2131,7 @@ struct v4l2_streamparm {
 #define V4L2_EVENT_FRAME_SYNC			4
 #define V4L2_EVENT_SOURCE_CHANGE		5
 #define V4L2_EVENT_MOTION_DET			6
+#define V4L2_EVENT_FRAME_INTERVAL_ERROR		7
 #define V4L2_EVENT_PRIVATE_START		0x08000000
 
 /* Payload for V4L2_EVENT_VSYNC */
-- 
2.7.4
