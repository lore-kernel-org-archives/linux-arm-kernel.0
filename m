From: stefan@agner.ch (Stefan Agner)
Date: Fri, 28 Nov 2014 01:23:21 +0100
Subject: [PATCH 0/4] serial: fsl_lpuart: fix various DMA related issues
Message-ID: <1417134205-4400-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1 and 3 are actual fixes, whereas 2 and 4 don't lead to issues
in standard cases but are still worthwhile fixes.

Stefan Agner (4):
  serial: fsl_lpuart: delete timer on shutdown
  serial: fsl_lpuart: move DMA channel request to probe
  serial: fsl_lpuart: avoid new transfer while DMA is running
  serial: fsl_lpuart: update RX timer on successful DMA transfer

 drivers/tty/serial/fsl_lpuart.c | 110 +++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 58 deletions(-)

-- 
2.1.3
