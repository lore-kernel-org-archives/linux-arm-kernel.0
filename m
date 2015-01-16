From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Jan 2015 17:11:26 +0100
Subject: [PATCHv2 0/3] ARM: mvebu: I/O coherency related fixes
Message-ID: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Andrew,

As we discussed, here is a set of 3 patches related to HW I/O
coherency on mvebu:

 * The first patch disables HW I/O coherency entirely, and is meant to
   be backported to stable, until we do enough testing of the new HW
   I/O coherency stuff and backport it to stabel.

 * The last two patches add the new HW I/O coherency strategy based on
   automatic I/O synchronization barriers, and obviously re-enable the
   HW I/O coherency.

I'd like all three patches to be merged for 3.20. The first patch will
be backported to stable right now, and we will continue to do more
testing around HW I/O coherency in 3.20 to validate that we have
reached a proper solution.

Special thanks to Simon Guinot who did quite a bit of testing of the
automatic I/O synchronization barriers, and to Arnd for all the
discussions related to this topic.

Thanks,

Thomas

Thomas Petazzoni (3):
  ARM: mvebu: completely disable hardware I/O coherency
  bus: mvebu-mbus: use automatic I/O synchronization barriers
  ARM: mvebu: use arm_coherent_dma_ops and re-enable hardware I/O
    coherency

 arch/arm/mach-mvebu/coherency.c | 56 ++++++-----------------------------------
 drivers/bus/mvebu-mbus.c        | 17 ++++++++++---
 2 files changed, 21 insertions(+), 52 deletions(-)

-- 
2.1.0
