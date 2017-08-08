From: phil@raspberrypi.org (Phil Elwell)
Date: Tue,  8 Aug 2017 12:04:54 +0100
Subject: [PATCH 0/1] ARM: bcm2836: Send event when onlining other cores
Message-ID: <1502190295-53391-1-git-send-email-phil@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This two-line patch adds the "sev" instruction required to wake the
secondary cores, should they be sleeping in a "wfe" instruction.
It applies on top of Eric's bcm2835-soc-smp-cleanup branch[1], after
Stefan's patchset moving the SMP startup code out of the irqchip
driver.

[1] - https://github.com/anholt/linux/commits/bcm2835-soc-smp-cleanup

Phil Elwell (1):
  ARM: bcm2836: Send event when onlining other cores

 arch/arm/mach-bcm/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
1.9.1
