From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 11 Oct 2013 19:15:30 +0300
Subject: [PATCH 00/11] ARM: OMAP2+: CM cleanup series
Message-ID: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A small cleanup set for CM. This basically gets rid of the omap2_cm_*
register accesses from the random code locations, and gathers these
under cm2xxx.c and cm3xxx.c. This is done in preparation for creating
a separate CM driver. The set also contains a couple of PRM cleanups
which I decided to take care of at the same time due to overlapping
code (PRCM interrupt handler + DSP reset.)

TODO: cleanup dsp bridge code (arch/arm/mach-omap2/dsp.c.)

Tested on OMAP3 beagle + 3.12-rc3.

If someone could verify the omap2 changes, that would be nice.

-Tero
