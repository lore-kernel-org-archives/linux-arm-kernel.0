From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 8 May 2012 09:22:31 +0530
Subject: [PATCH V3 Resend 04/12] usb/marvell: Remove conditional compilation
 of clk code
In-Reply-To: <cover.1336448639.git.viresh.kumar@st.com>
References: <cover.1336448639.git.viresh.kumar@st.com>
Message-ID: <1f90c0a36fcae7ad45aef2634c8223600f0b64b8.1336448639.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.linux@gmail.com>

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
