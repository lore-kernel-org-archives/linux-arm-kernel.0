From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:35:51 +0000
Subject: [PATCH 17/33] MFD: ucb1x00-core: get rid of mach/hardware.h include
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3x1-0000Yt-62@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing in this driver requires anything from the machine/platform
headers, so remove this needless header file.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 6825169..cc1c0dc 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -29,8 +29,6 @@
 #include <linux/gpio.h>
 #include <linux/semaphore.h>
 
-#include <mach/hardware.h>
-
 static DEFINE_MUTEX(ucb1x00_mutex);
 static LIST_HEAD(ucb1x00_drivers);
 static LIST_HEAD(ucb1x00_devices);
-- 
1.7.4.4
