From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 27 Dec 2013 12:38:31 +0100
Subject: [PATCH 0/3] dma: mv_xor: spinlock related improvements
Message-ID: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod, Dan,

Here are three patches that make improvements to the spinlock handling
of the mv_xor driver. The first patch fixes a lock/release of the
channel spinlock in mv_xor_status(), and the next two patches make
followup code improvements/refactoring.

Ezequiel, it would be good to have your review on these patches, since
I know you've spent some time lately doing mv_xor stuff.

Thanks!

Thomas

Thomas Petazzoni (3):
  dma: mv_xor: take channel spinlock in mv_xor_status()
  dma: mv_xor: use __mv_xor_slot_cleanup() in
    mv_xor_free_chan_resources()
  dma: mv_xor: rename __mv_xor_slot_cleanup() to mv_xor_slot_cleanup()

 drivers/dma/mv_xor.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
1.8.3.2
