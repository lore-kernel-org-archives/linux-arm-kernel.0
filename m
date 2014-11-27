From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 27 Nov 2014 17:51:31 +0200
Subject: [PATCH 00/23] ARM: OMAP2+: PRCM cleanups towards 3.19 / part2
Message-ID: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Yet another PRCM cleanup set, towards making PRCM a separate driver.
This set is most likely too late for 3.19, but hopefully it can make
it to 3.20. Couple of related clock patches are also within this set,
as some of the clock support code is now obsolete. Most important
things this set does, is to separate the PRCM driver initializations
under their own parts, and split the control module init under its
own driver file also. This set still does not introduce regmap support
for PRCM, as I am not too sure whether it should be done at all.
It seems we can implement all the clock / vcvp / etc. support rather
neatly just with using iomaps.

Testing done:

am335x-evm: boot
am335x-sk: boot
am3517-evm: boot
am43xx-gpevm: boot
beaglebone-black: boot
beaglebone: boot
dra7xx-evm: boot
omap5-evm: boot
omap3-beagle: boot, suspend (ret), suspend (off) (UART wakeup seems broken on 3.18-rc1 btw)
omap4-panda-es: boot

Testing branch pushed here:
tree: https://github.com/t-kristo/linux-pm.git
branch: for-v3.19/prcm-cleanup-part2

This is based on top of Tony's omap-for-v3.19/prcm.

-Tero
