From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 26 Mar 2010 15:38:10 +0530
Subject: [PATCH] removing compilation warning from pl061.h
Message-ID: <1269598090-12329-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pl061.h is using u8 type. including <linux/types.h> in pl061.h to avoid
warning.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/amba/pl061.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/amba/pl061.h b/include/linux/amba/pl061.h
index b4fbd98..5ddd9ad 100644
--- a/include/linux/amba/pl061.h
+++ b/include/linux/amba/pl061.h
@@ -1,3 +1,5 @@
+#include <linux/types.h>
+
 /* platform data for the PL061 GPIO driver */
 
 struct pl061_platform_data {
-- 
1.6.0.2
