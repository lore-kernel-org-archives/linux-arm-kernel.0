From: w@1wt.eu (Willy Tarreau)
Date: Sun, 17 Jun 2012 14:56:51 +0200
Subject: [PATCH] arm: fix iconnect build
Message-ID: <20120617125651.GH8450@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

iconnect does not build in 3.5-rc3 due to missing file orion-spi.h.
The following trivial patch fixes it.

Regards,
Willy

--
>From d80dd4aa064c26a27af107819227b1d602b33105 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sun, 17 Jun 2012 08:43:47 +0200
Subject: [PATCH] arm: board-iconnect: orion_spi.h is gone

Fix build error due to missing orion_spi.h.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/mach-kirkwood/board-iconnect.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index 2222c57..fa1cbdb 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -22,7 +22,6 @@
 #include <linux/leds.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/orion_spi.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
-- 
1.7.2.1.45.g54fbc
