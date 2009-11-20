From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2009 11:03:29 +0000
Subject: [PATCH 1/2] ARM: PNX4008: fix i2c-pnx.c build errors
In-Reply-To: <20091120135932.GA16920@n2100.arm.linux.org.uk>
References: <20091120135932.GA16920@n2100.arm.linux.org.uk>
Message-ID: <f639bcd4278415ccf72dbc3b602670ac4dab040d.1258725164.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... caused by a missing include.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-pnx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 6ff6c20..3ae5647 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -22,6 +22,7 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
+#include <mach/i2c.h>
 
 #define I2C_PNX_TIMEOUT		10 /* msec */
 #define I2C_PNX_SPEED_KHZ	100
-- 
1.6.2.5
