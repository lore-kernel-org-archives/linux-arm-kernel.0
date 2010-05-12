From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:36:04 +0100
Subject: [PATCH 13/15] ARM: S3C2416: Use s3c2440 style i2c controller
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-13-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c2416 i2c controllers are compatible with the s3c2440 style i2c
block, so change the device name appropriately.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>y
---
 arch/arm/mach-s3c2416/s3c2416.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 6165dc7..ad5a63a 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -50,6 +50,8 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
+#include <plat/iic-core.h>
+
 static struct map_desc s3c2416_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
 	IODESC_ENT(CLKPWR),
@@ -80,6 +82,10 @@ int __init s3c2416_init(void)
 	s3c_device_wdt.resource[1].start = IRQ_S3C2443_WDT;
 	s3c_device_wdt.resource[1].end   = IRQ_S3C2443_WDT;
 
+	/* the i2c devices are directly compatible with s3c2440 */
+	s3c_i2c0_setname("s3c2440-i2c");
+	s3c_i2c1_setname("s3c2440-i2c");
+
 	return sysdev_register(&s3c2416_sysdev);
 }
 
-- 
1.6.3.3
