From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sun, 14 Jul 2013 14:27:38 +0000
Subject: [PATCH] ARM: keystone: drop "select HAVE_SCHED_CLOCK"
In-Reply-To: <1373798285.1370.2.camel@x61.thuisdomein>
References: <1373798285.1370.2.camel@x61.thuisdomein>
Message-ID: <448912EABC71F84BBCADFD3C67C4BE52826E9F@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for top posting. Thanks for the patch. I will pick this up.

Regards,
Santosh
________________________________________
From: Paul Bolle [pebolle at tiscali.nl]
Sent: Sunday, July 14, 2013 6:38 AM
To: Russell King
Cc: Olof Johansson; Shilimkar, Santosh; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
Subject: [PATCH] ARM: keystone: drop "select HAVE_SCHED_CLOCK"

The Kconfig symbol HAVE_SCHED_CLOCK got removed in v3.4,
with commit 6905a65879b5 ("ARM: Make the sched_clock
framework mandatory"). But a select statement for it popped up again
through commit 828989ad87af ("ARM: keystone: Add minimal TI Keystone
platform support"). Drop that statement, as it is useless.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Not tested.

 arch/arm/mach-keystone/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 51a50e9..366d1a3 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -7,7 +7,6 @@ config ARCH_KEYSTONE
        select HAVE_SMP
        select CLKSRC_MMIO
        select GENERIC_CLOCKEVENTS
-       select HAVE_SCHED_CLOCK
        select ARCH_WANT_OPTIONAL_GPIOLIB
        select ARM_ERRATA_798181 if SMP
        help
--
1.8.1.4
