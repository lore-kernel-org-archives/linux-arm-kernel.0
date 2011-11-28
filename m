From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 28 Nov 2011 15:09:07 +0000
Subject: [PATCH v2 0/4] Versatile Express DT support
In-Reply-To: <20111128145700.GC2465@localhost.localdomain>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
 <4ED399C8.9080908@gmail.com>  <20111128145700.GC2465@localhost.localdomain>
Message-ID: <1322492947.3164.44.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-11-28 at 14:57 +0000, Dave Martin wrote:
> Oh, btw, git am reports a few whitespace errors on the last full post of
> the series (v2).
> 
> Can you shove the series through checkpatch.pl and/or git am and fix any
> minor issues, now that the series is relatively stable?

I did, actually:

8<--------------------------------------------------------------------
$ scripts/checkpatch.pl 0001-ARM-vexpress-Get-rid-of-MMIO_P2V.patch 
total: 0 errors, 0 warnings, 363 lines checked

0001-ARM-vexpress-Get-rid-of-MMIO_P2V.patch has no obvious style problems and is ready for submission.
$ scripts/checkpatch.pl 0002-ARM-vexpress-Add-DT-support-in-v2m.patch 
total: 0 errors, 0 warnings, 505 lines checked

0002-ARM-vexpress-Add-DT-support-in-v2m.patch has no obvious style problems and is ready for submission.
$ scripts/checkpatch.pl 0003-ARM-vexpress-Initial-RS1-memory-map-support.patch 
WARNING: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
#308: FILE: arch/arm/mach-vexpress/include/mach/uncompress.h:25:
+#define AMBA_PERIPH_ID0(base)	(*(volatile unsigned char *)((base) + 0xfe0))

total: 0 errors, 1 warnings, 368 lines checked

0003-ARM-vexpress-Initial-RS1-memory-map-support.patch has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
$ scripts/checkpatch.pl 0004-ARM-vexpress-DT-based-support-for-CoreTiles-Express-.patch 
total: 0 errors, 0 warnings, 424 lines checked

0004-ARM-vexpress-DT-based-support-for-CoreTiles-Express-.patch has no obvious style problems and is ready for submission.
8<--------------------------------------------------------------------


In the past I noticed that same - sometimes git am is complaining when
chechpatch is clean. I never was determined to figure out why, though...

Pawe?
