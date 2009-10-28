From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:53 +0000
Subject: [PATCH 12/12] ARM: S3C2410: Fix sparse warnings in
	arch/arm/mach-s3c2410/gpio.c
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1256732153-22027-12-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix sparse warning in arch/arm/mach-s3c2410/gpio.c due to missing
include of <mach/gpio-fns.h>. Fixes the following warning:

warning: symbol 's3c2410_gpio_irqfilter' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/gpio.c b/arch/arm/mach-s3c2410/gpio.c
index 7974afc..9664e01 100644
--- a/arch/arm/mach-s3c2410/gpio.c
+++ b/arch/arm/mach-s3c2410/gpio.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/gpio-fns.h>
 #include <asm/irq.h>
 
 #include <mach/regs-gpio.h>
-- 
1.6.3.3
