From: christophe.leroy@c-s.fr (Christophe Leroy)
Date: Tue,  7 Feb 2017 10:05:05 +0100 (CET)
Subject: [PATCH 0/2] get rid of immrbar_virt_to_phys()
Message-ID: <cover.1486456900.git.christophe.leroy@c-s.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ucc_geth ethernet driver is the only driver using immrbar_virt_to_phys() and it uses it incorrectly.

This patch fixes ucc_geth driver then removes immrbar_virt_to_phys()

Christophe Leroy (2):
  net: ethernet: ucc_geth: fix MEM_PART_MURAM mode
  soc/fsl/qe: get rid of immrbar_virt_to_phys()

 drivers/net/ethernet/freescale/ucc_geth.c |  8 +++-----
 drivers/soc/fsl/qe/qe.c                   |  2 --
 include/soc/fsl/qe/immap_qe.h             | 19 -------------------
 include/soc/fsl/qe/qe.h                   |  1 +
 4 files changed, 4 insertions(+), 26 deletions(-)

-- 
2.10.1
