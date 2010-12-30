From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 30 Dec 2010 19:25:00 +0800
Subject: [PATCH v4 1/8] ARM: mx5: use config to define boot related addresses
Message-ID: <1293708306-20170-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Makefile.boot |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
index 9939a19..fec7cd9 100644
--- a/arch/arm/mach-mx5/Makefile.boot
+++ b/arch/arm/mach-mx5/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x90008000
-params_phys-y	:= 0x90000100
-initrd_phys-y	:= 0x90800000
+   zreladdr-$(CONFIG_ARCH_MX51)	:= 0x90008000
+params_phys-$(CONFIG_ARCH_MX51)	:= 0x90000100
+initrd_phys-$(CONFIG_ARCH_MX51)	:= 0x90800000
-- 
1.6.3.3
