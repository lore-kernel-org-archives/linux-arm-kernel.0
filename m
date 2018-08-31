From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 31 Aug 2018 16:08:10 +0800
Subject: [PATCH net-next v2 0/3] net: mvneta: some small improvements
Message-ID: <20180831160810.2539ef4c@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch1 removes the NETIF_F_GRO check ourself, because the net subsystem
will handle it for us.

patch2 enables NETIF_F_RXCSUM by default, since the driver and HW
supports the feature.

patch3 is a small optimization, to reduce smp_processor_id() calling
in mvneta_tx_done_gbe.

since v1:
 - based on net-next tree
 - remove the fix patches, since they should be based on net branch.
 - Add Gregory's Reviewed-by tag

Jisheng Zhang (3):
  net: mvneta: Don't check NETIF_F_GRO ourself
  net: mvneta: enable NETIF_F_RXCSUM by default
  net: mvneta: reduce smp_processor_id() calling in mvneta_tx_done_gbe

 drivers/net/ethernet/marvell/mvneta.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.18.0
