From: viresh.linux@gmail.com (Viresh Kumar)
Date: Sat, 21 Apr 2012 17:17:39 +0530
Subject: [PATCH 12/13] usb/marvell: Remove conditional compilation of clk code
In-Reply-To: <cover.1335008617.git.viresh.kumar@st.com>
References: <cover.1335008617.git.viresh.kumar@st.com>
Message-ID: <13bbe0f3079bbf373d898fba7602daca0561e84d.1335008617.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
macros.

Marvell usb also has these dummy macros defined locally. Remove them as they
aren't required anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
---
 include/linux/platform_data/mv_usb.h |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platform_data/mv_usb.h
index d94804a..944b01d 100644
--- a/include/linux/platform_data/mv_usb.h
+++ b/include/linux/platform_data/mv_usb.h
@@ -52,13 +52,4 @@ struct mv_usb_platform_data {
 	int	(*set_vbus)(unsigned int vbus);
 	int     (*private_init)(void __iomem *opregs, void __iomem *phyregs);
 };
-
-#ifndef CONFIG_HAVE_CLK
-/* Dummy stub for clk framework */
-#define clk_get(dev, id)       NULL
-#define clk_put(clock)         do {} while (0)
-#define clk_enable(clock)      do {} while (0)
-#define clk_disable(clock)     do {} while (0)
-#endif
-
 #endif
-- 
1.7.9
