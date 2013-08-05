From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 14:11:08 -0400
Subject: [RESEND PATCH 1/7] ARM: keystone: drop useless HAVE_SCHED_CLOCK
In-Reply-To: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375726274-26000-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Bolle <pebolle@tiscali.nl>

The Kconfig symbol HAVE_SCHED_CLOCK got removed in v3.4,
with commit 6905a65879b5 ("ARM: Make the sched_clock
framework mandatory"). But a select statement for it popped up again
through commit 828989ad87af ("ARM: keystone: Add minimal TI Keystone
platform support"). Drop that statement, as it is useless.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
[santosh.shilimkar at ti.com: Minor edit in the subject]
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 51a50e9..366d1a3 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -7,7 +7,6 @@ config ARCH_KEYSTONE
 	select HAVE_SMP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
-	select HAVE_SCHED_CLOCK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_ERRATA_798181 if SMP
 	help
-- 
1.7.9.5
