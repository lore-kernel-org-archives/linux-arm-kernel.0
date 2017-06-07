From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed,  7 Jun 2017 11:33:59 -0700
Subject: [PATCH v8 20/34] media: imx: Add a TODO file
In-Reply-To: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1496860453-6282-21-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a TODO file.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/TODO | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 drivers/staging/media/imx/TODO

diff --git a/drivers/staging/media/imx/TODO b/drivers/staging/media/imx/TODO
new file mode 100644
index 0000000..0bee313
--- /dev/null
+++ b/drivers/staging/media/imx/TODO
@@ -0,0 +1,23 @@
+
+- Clean up and move the ov5642 subdev driver to drivers/media/i2c, or
+  merge support for OV5642 into drivers/media/i2c/ov5640.c, and create
+  the binding docs for it.
+
+- The Frame Interval Monitor could be exported to v4l2-core for
+  general use.
+
+- At driver load time, the device-tree node that is the original source
+  (the "sensor"), is parsed to record its media bus configuration, and
+  this info is required in imx-media-csi.c to setup the CSI.
+  Laurent Pinchart argues that instead the CSI subdev should call its
+  neighbor's g_mbus_config op (which should be propagated if necessary)
+  to get this info. However Hans Verkuil is planning to remove the
+  g_mbus_config op. For now this driver uses the parsed DT mbus config
+  method until this issue is resolved.
+
+- This media driver supports inheriting V4L2 controls to the
+  video capture devices, from the subdevices in the capture device's
+  pipeline. The controls for each capture device are updated in the
+  link_notify callback when the pipeline is modified. It should be
+  decided whether this feature is useful enough to make it generally
+  available by exporting to v4l2-core.
-- 
2.7.4
