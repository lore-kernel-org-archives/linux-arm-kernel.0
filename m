From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Mar 2014 16:46:44 -0300
Subject: [PATCH v2 0/3] mv_xor: Spinlock cleanup
Message-ID: <1394221607-15064-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod, Dan,

This series is v2 of the one previously sent by Thomas Petazzoni [1].
I've tried to address the comments made by Andi and Dan, and also kept
Thomas' ultimate goal: get rid of the mv_xor_slot_cleanup() function
(which takes the spinlock).

The first patch removes the unneeded call to mv_xor_clean_completed_slots(),
in mv_xor_as explained by Dan [2].

The other two patches replace the calls to mv_xor_slot_cleanup() with
calls to __mv_xor_slot_cleanup(). This allows to have the same "spinlock held"
requirement on all callers.

The patchset is based on v3.14-rc5 and has been tested on an Armada XP GP board.

[1] http://www.spinics.net/lists/arm-kernel/msg297176.html
[2] http://www.spinics.net/lists/arm-kernel/msg297518.html

Ezequiel Garcia (3):
  dma: mv_xor: Remove unneeded mv_xor_clean_completed_slots() call
  dma: mv_xor: Remove all callers of mv_xor_slot_cleanup()
  dma: mv_xor: Rename __mv_xor_slot_cleanup() to mv_xor_slot_cleanup()

 drivers/dma/mv_xor.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

-- 
1.9.0
