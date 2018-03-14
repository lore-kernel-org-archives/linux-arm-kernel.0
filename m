From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 14 Mar 2018 08:37:27 -0500
Subject: [PATCH 0/5] DPAA Ethernet fixes
Message-ID: <20180314133732.24068-1-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set is addressing several issues in the DPAA Ethernet
driver suite:

 - module unload crash caused by wrong reference to device being left
   in the cleanup code after the DSA related changes
 - scheduling wile atomic bug in QMan code revealed during dpaa_eth
   module unload
 - a couple of error counter fixes, a duplicated init in dpaa_eth.

Madalin

Camelia Groza (3):
  dpaa_eth: remove duplicate initialization
  dpaa_eth: increment the RX dropped counter when needed
  dpaa_eth: remove duplicate increment of the tx_errors counter

Madalin Bucur (2):
  soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
  dpaa_eth: fix error in dpaa_remove()

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  8 ++++----
 drivers/soc/fsl/qbman/qman.c                   | 28 +++++---------------------
 2 files changed, 9 insertions(+), 27 deletions(-)

-- 
2.1.0
