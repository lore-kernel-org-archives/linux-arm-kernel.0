From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 10:38:55 +0100
Subject: [PATCHv3 0/5] ARM: mvebu: no I/O coherency on non-SMP and related
 updates
Message-ID: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series makes a number of updates to the I/O coherency code of
Marvell EBU platforms.

Changes since v2:

 - Drop patch "ARM: mvebu: add missing of_node_put() call in
   coherency.c" since it was merged.

 - Update "make the coherency_ll.S functions work with no coherency
   fabric" to use "reteq <reg>" instead of "moveq pc, <reg>", as
   suggested by Gr?gory Clement.

 - Update the comment in "disable I/O coherency on non-SMP situations
   on Armada 370/375/38x/XP" to give more details about what would be
   needed to get HW I/O coherency working on Armada 370, as suggested
   by Jason Cooper.

 - Added Acked-by from Gr?gory Clement as appropriate.

 - Added one patch to drop the Armada 375 Z1 workaround for I/O
   coherency, which removes a significant chunk of code from
   coherency.c.

 - Added two patches doing minor cleanup/updates to coherency.c

Changes since v1:

 - Rebased on top of v3.18-rc2.
 - Added some Fixes:/Cc: tags on the last patch to get it merged into
   the stable tree, as it fixes a real DT reference count leak.

Best regards,

Thomas Petazzoni

Thomas Petazzoni (5):
  ARM: mvebu: make the coherency_ll.S functions work with no coherency
    fabric
  ARM: mvebu: disable I/O coherency on non-SMP situations on Armada
    370/375/38x/XP
  ARM: mvebu: remove unused register offset definition
  ARM: mvebu: remove Armada 375 Z1 workaround for I/O coherency
  ARM: mvebu: update comments in coherency.c

 arch/arm/mach-mvebu/coherency.c    | 220 ++++++-------------------------------
 arch/arm/mach-mvebu/coherency_ll.S |  21 +++-
 2 files changed, 55 insertions(+), 186 deletions(-)

-- 
2.0.0
