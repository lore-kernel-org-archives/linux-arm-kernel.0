From: robdclark@gmail.com (Rob Clark)
Date: Tue, 22 Jan 2013 15:46:00 -0600
Subject: [PATCH] OMAPDSS: enable omapdss for ARCH_MULTIPLATFORM
Message-ID: <1358891160-9534-1-git-send-email-robdclark@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least core omapdss does not have any build dependencies on
ARCH_OMAP2PLUS, and adding this dependency in the Kconfig breaks omapdrm
for ARCH_MULTIPLATFORM builds.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/video/omap2/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/Kconfig b/drivers/video/omap2/Kconfig
index b07b2b0..011e549 100644
--- a/drivers/video/omap2/Kconfig
+++ b/drivers/video/omap2/Kconfig
@@ -1,9 +1,14 @@
 config OMAP2_VRFB
 	bool
 
-if ARCH_OMAP2PLUS
+if ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM
 
 source "drivers/video/omap2/dss/Kconfig"
+
+endif
+
+if ARCH_OMAP2PLUS
+
 source "drivers/video/omap2/omapfb/Kconfig"
 source "drivers/video/omap2/displays/Kconfig"
 
-- 
1.8.1
