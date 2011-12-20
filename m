From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Dec 2011 20:00:42 +0800
Subject: [PATCH 11/12] clk: add config option HAVE_CLK_PREPARE into Kconfig
In-Reply-To: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1324382443-4439-12-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 40d3e0f (clk: provide prepare/unprepare functions) provides
the config option HAVE_CLK_PREPARE for platforms that have
prepare/unprepare implementation to select.  This patch adds the option
into drivers/clk/Kconfig, so that it can be actually selected.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/clk/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3530927..9b3cd08 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -3,5 +3,8 @@ config CLKDEV_LOOKUP
 	bool
 	select HAVE_CLK
 
+config HAVE_CLK_PREPARE
+	bool
+
 config HAVE_MACH_CLKDEV
 	bool
-- 
1.7.4.1
