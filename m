From: viresh.linux@gmail.com (Viresh Kumar)
Date: Sat, 21 Apr 2012 17:17:30 +0530
Subject: [PATCH 03/13] clk: CLK_PREPARE must depend on HAVE_CLK
In-Reply-To: <cover.1335008617.git.viresh.kumar@st.com>
References: <cover.1335008617.git.viresh.kumar@st.com>
Message-ID: <ffaffaeeb39c5b7741ee8e616682d51d213fa512.1335008617.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_PREPARE must have dependency on HAVE_CLK. Add it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4f10a21..8281056 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -5,6 +5,7 @@ config CLKDEV_LOOKUP
 
 config HAVE_CLK_PREPARE
 	bool
+	depends on HAVE_CLK
 
 config HAVE_MACH_CLKDEV
 	bool
-- 
1.7.9
