From: robherring2@gmail.com (Rob Herring)
Date: Mon,  9 Apr 2012 15:24:58 -0500
Subject: [PATCH 1/4] clk: select CLKDEV_LOOKUP for COMMON_CLK
In-Reply-To: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
References: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
Message-ID: <1334003101-17274-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Using the common clock infrastructure without the common clkdev code makes
little sense, so select CLKDEV_LOOKUP for COMMON_CLK.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/clk/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 165e1fe..f05a60d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -12,6 +12,7 @@ config HAVE_MACH_CLKDEV
 config COMMON_CLK
 	bool
 	select HAVE_CLK_PREPARE
+	select CLKDEV_LOOKUP
 	---help---
 	  The common clock framework is a single definition of struct
 	  clk, useful across many platforms, as well as an
-- 
1.7.5.4
