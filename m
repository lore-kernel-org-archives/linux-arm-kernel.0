From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 15:33:32 +0530
Subject: [PATCH] Including device.h and resource.h header files in
	linux/amba/bus.h
Message-ID: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linux/amba/bus.h have dependencies on linux/device.h and linux/resource.h, but
it doesn't include them. We get compilation errors in our files which include
bus.h but doesn't include device.h and resource.h. This patch includes device.h
and resource.h in linux/amba/bus.h file.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/amba/bus.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 6816be6..8b10386 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -14,6 +14,9 @@
 #ifndef ASMARM_AMBA_H
 #define ASMARM_AMBA_H
 
+#include <linux/device.h>
+#include <linux/resource.h>
+
 #define AMBA_NR_IRQS	2
 
 struct amba_device {
-- 
1.6.0.2
