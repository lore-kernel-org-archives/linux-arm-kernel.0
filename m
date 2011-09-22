From: mturquette@ti.com (Mike Turquette)
Date: Thu, 22 Sep 2011 15:27:00 -0700
Subject: [PATCH v2 5/7] clk: Add Kconfig option to build all generic clk
	drivers
In-Reply-To: <1316730422-20027-1-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
Message-ID: <1316730422-20027-6-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Currently drivers for the generic clk subsystem must be selected by
platforms using them in order to enable build. When doing development on
the API or generic build time testing it is useful to be able to build
unused drivers in order to improve coverage so supply a Kconfig option
which allows this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
No change since v1

 drivers/clk/Kconfig |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index a78967c..95b42a3 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -1,4 +1,3 @@
-
 config CLKDEV_LOOKUP
 	bool
 	select HAVE_CLK
@@ -9,6 +8,16 @@ config HAVE_MACH_CLKDEV
 config GENERIC_CLK
 	bool
 
+config GENERIC_CLK_BUILD_TEST
+	bool "Build all generic clock drivers"
+	depends on EXPERIMENTAL && GENERIC_CLK
+	select GENERIC_CLK_FIXED
+	select GENERIC_CLK_GATE
+	help
+	   Enable all possible generic clock drivers.  This is only
+	   useful for improving build coverage, it is not useful for
+	   production kernel builds.
+
 config GENERIC_CLK_FIXED
 	bool
 	depends on GENERIC_CLK
-- 
1.7.4.1
