From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 16:51:24 +0530
Subject: [PATCH V3 02/12] clk: Remove redundant depends on from drivers/Kconfig
In-Reply-To: <cover.1335266056.git.viresh.kumar@st.com>
References: <cover.1335266056.git.viresh.kumar@st.com>
Message-ID: <645cc6b3f7be68c5d04222533f3f9d1d5ab9ab17.1335266056.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

menu "Common Clock Framework" has "depends on COMMON_CLK" and so configs defined
within menu don't require these "depends on COMMON_CLK again".

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 165e1fe..4f10a21 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -24,7 +24,6 @@ menu "Common Clock Framework"
 
 config COMMON_CLK_DISABLE_UNUSED
 	bool "Disabled unused clocks at boot"
-	depends on COMMON_CLK
 	---help---
 	  Traverses the entire clock tree and disables any clocks that are
 	  enabled in hardware but have not been enabled by any device drivers.
@@ -35,7 +34,6 @@ config COMMON_CLK_DISABLE_UNUSED
 
 config COMMON_CLK_DEBUG
 	bool "DebugFS representation of clock tree"
-	depends on COMMON_CLK
 	select DEBUG_FS
 	---help---
 	  Creates a directory hierchy in debugfs for visualizing the clk
-- 
1.7.9
