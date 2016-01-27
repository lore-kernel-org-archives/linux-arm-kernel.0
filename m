From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 Jan 2016 17:11:12 +0100
Subject: [PATCH v4 13/13] clk: at91: remove useless includes
In-Reply-To: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1453911072-23608-14-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Over time, some includes were copy pasted from other clocks drivers but are
not necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/clk-generated.c    | 2 --
 drivers/clk/at91/clk-h32mx.c        | 8 --------
 drivers/clk/at91/clk-peripheral.c   | 2 --
 drivers/clk/at91/clk-plldiv.c       | 2 --
 drivers/clk/at91/clk-programmable.c | 4 ----
 drivers/clk/at91/clk-slow.c         | 8 --------
 drivers/clk/at91/clk-smd.c          | 2 --
 drivers/clk/at91/clk-usb.c          | 2 --
 8 files changed, 30 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 5866684a6657..4ad3298eb372 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -15,8 +15,6 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/clk/at91/clk-h32mx.c b/drivers/clk/at91/clk-h32mx.c
index 3fd59b129f92..819f5842fa66 100644
--- a/drivers/clk/at91/clk-h32mx.c
+++ b/drivers/clk/at91/clk-h32mx.c
@@ -15,15 +15,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
-#include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 33c31d43dd8d..fd160728e990 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -12,8 +12,6 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/clk/at91/clk-plldiv.c b/drivers/clk/at91/clk-plldiv.c
index f43e93738a99..2bed26481027 100644
--- a/drivers/clk/at91/clk-plldiv.c
+++ b/drivers/clk/at91/clk-plldiv.c
@@ -12,8 +12,6 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 78814ba448c4..bc0be629671b 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -12,10 +12,6 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index 1f76113db889..911e941f8318 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -12,19 +12,11 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
-#include <linux/slab.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
 
 #include "pmc.h"
 #include "sckc.h"
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index 0f6e8d67e630..e6948a52005a 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -12,8 +12,6 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 617e24f6ef76..650ca45892c0 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -12,8 +12,6 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
-- 
2.5.0
