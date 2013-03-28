From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 28 Mar 2013 12:59:46 +0530
Subject: [PATCH 4/9] ARM: OMAP4+: Remove the un-necessary cache flush
 from hotplug code
In-Reply-To: <51535AF4.3090607@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-5-git-send-email-santosh.shilimkar@ti.com>
 <87ehf07kfn.fsf@linaro.org> <51535AF4.3090607@ti.com>
Message-ID: <5153F16A.5070307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013 02:17 AM, Santosh Shilimkar wrote:
> On Thursday 28 March 2013 12:13 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> This was added with intial port where OMAP PM support wasn't existing
>>> and only simple WFI based hooks were used.
>>>
>>> This should have been cleaned up while adding the PM support but some
>>> how fall through cracks.
>>
>> Changelog describes a bit of history, but does not it's no longer
>> needed.
>>
> I thought "This should have been cleaned up while adding PM support"
> means its no longer needed. At least I meant that way.
> 
> Anyway I will just make it explicit.
> 
For record, patch with updated changelog end of email.

Regards,
Santosh


>From 4df9c29bf6eec23e99e83c9e1531603af69b4b42 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sun, 10 Feb 2013 13:14:17 +0530
Subject: [PATCH v2 4/9] ARM: OMAP4+: Remove the un-necessary cache flush from
 hotplug code

This was added with intial port where OMAP PM support wasn't existing
and only simple WFI based hooks were used.

This should have been cleaned up while adding the PM support but some
how fall through cracks.

So remove the cache flush code which is no longer needed now.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index e712d17..458f72f 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -19,11 +19,8 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <asm/cacheflush.h>
 #include "omap-wakeupgen.h"
-
 #include "common.h"
-
 #include "powerdomain.h"
 
 /*
@@ -35,9 +32,6 @@ void __ref omap4_cpu_die(unsigned int cpu)
 	unsigned int boot_cpu = 0;
 	void __iomem *base = omap_get_wakeupgen_base();
 
-	flush_cache_all();
-	dsb();
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
-- 
1.7.9.5
