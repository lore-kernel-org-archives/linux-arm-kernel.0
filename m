From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Wed, 29 Aug 2018 16:25:57 +0800
Subject: [PATCH 0/5] net: mvneta: some bug fix and trivial improvement
Message-ID: <20180829162456.2bd69796@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch1 fixes rx_offset_correction set and usage. Because the
rx_offset_correction is RX packet offset correction for platforms,
it's not related with SW BM, instead, it's only related with the
platform's NET_SKB_PAD.

patch2 fixes the wrong function to unmap rx buf

patch3 removes the NETIF_F_GRO check ourself, because the net subsystem
will handle it for us.

patch4 enables NETIF_F_RXCSUM by default, since the driver and HW
supports the feature.

patch5 is a trivial optimization, to reduce smp_processor_id() calling
in mvneta_tx_done_gbe.

Jisheng Zhang (5):
  net: mvneta: fix rx_offset_correction set and usage
  net: mvneta: fix the wrong function to unmap rx buf
  net: mvneta: Don't check NETIF_F_GRO ourself
  net: mvneta: enable NETIF_F_RXCSUM by default
  net: mvneta: reduce smp_processor_id() calling in mvneta_tx_done_gbe

 drivers/net/ethernet/marvell/mvneta.c | 49 ++++++++++++---------------
 1 file changed, 22 insertions(+), 27 deletions(-)

-- 
2.18.0
