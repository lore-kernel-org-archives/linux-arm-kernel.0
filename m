From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  9 Dec 2011 16:59:03 -0700
Subject: [PATCH 1/3] pinctrl: Implement PINMUX_MAP_SYS_HOG
Message-ID: <1323475145-26430-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the same as PINMUX_MAP_PRIMARY_SYS_HOG, except that it allows
you to specify a particular control device.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/linux/pinctrl/machine.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
index f537231..0ca32eb 100644
--- a/include/linux/pinctrl/machine.h
+++ b/include/linux/pinctrl/machine.h
@@ -66,6 +66,14 @@ struct pinmux_map {
 	{ .name = a, .ctrl_dev_name = b, .function = c }
 
 /*
+ * Convenience macro to map a system function onto a certain pinctrl device,
+ * to be hogged by the pinmux core until the system shuts down.
+ */
+#define PINMUX_MAP_SYS_HOG(a, b, c) \
+	{ .name = a, .ctrl_dev_name = b, .function = c, \
+	  .hog_on_boot = true }
+
+/*
  * Convenience macro to map a function onto the primary device pinctrl device
  * this is especially helpful on systems that have only one pin controller
  * or need to set up a lot of mappings on the primary controller.
-- 
1.7.0.4
