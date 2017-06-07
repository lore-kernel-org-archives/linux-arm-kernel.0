From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed,  7 Jun 2017 11:33:57 -0700
Subject: [PATCH v8 18/34] media: Add userspace header file for i.MX
In-Reply-To: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1496860453-6282-19-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a header file for use by userspace programs wanting to interact
with the i.MX media driver. It defines custom events and v4l2 controls for
the i.MX v4l2 subdevices.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 include/linux/imx-media.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 include/linux/imx-media.h

diff --git a/include/linux/imx-media.h b/include/linux/imx-media.h
new file mode 100644
index 0000000..77221ec
--- /dev/null
+++ b/include/linux/imx-media.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2014-2017 Mentor Graphics Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version
+ */
+
+#ifndef __LINUX_IMX_MEDIA_H__
+#define __LINUX_IMX_MEDIA_H__
+
+/*
+ * events from the subdevs
+ */
+#define V4L2_EVENT_IMX_CLASS                V4L2_EVENT_PRIVATE_START
+#define V4L2_EVENT_IMX_FRAME_INTERVAL_ERROR (V4L2_EVENT_IMX_CLASS + 1)
+
+enum imx_ctrl_id {
+	V4L2_CID_IMX_FIM_ENABLE = (V4L2_CID_USER_IMX_BASE + 0),
+	V4L2_CID_IMX_FIM_NUM,
+	V4L2_CID_IMX_FIM_TOLERANCE_MIN,
+	V4L2_CID_IMX_FIM_TOLERANCE_MAX,
+	V4L2_CID_IMX_FIM_NUM_SKIP,
+	V4L2_CID_IMX_FIM_ICAP_EDGE,
+	V4L2_CID_IMX_FIM_ICAP_CHANNEL,
+};
+
+#endif
-- 
2.7.4
