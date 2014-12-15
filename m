From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 15 Dec 2014 15:13:30 +0100
Subject: [PATCH 0/2] net/macb: fix multiqueue support patch up
Message-ID: <cover.1418651689.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches is a fixup for the multiqueue support patch.

The first patch fixes a bug introduced by the multiqueue support patch.
The second one doesn't fix a bug but simplify the source code by removing
useless calls to devm_free_irq() since we use managed device resources for
IRQs.

They were applied on the net-next tree and tested with a sama5d36ek board.

Cyrille Pitchen (2):
  net/macb: fix misplaced call of free_netdev() in macb_remove()
  net/macb: remove useless calls of devm_free_irq()

 drivers/net/ethernet/cadence/macb.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

-- 
1.8.2.2
