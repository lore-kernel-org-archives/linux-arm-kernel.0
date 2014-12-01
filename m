From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 1 Dec 2014 15:35:05 +0100
Subject: [PATCH v4 0/4] mmc: atmel-mci: cleanup and probe deferring
Message-ID: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

Same as previous series, based on your next branch, and no errors with
checkpatch so let me know if you still have troubles to apply my patches.

Changes from v3:
- keep __init/__exit attributes for atmci_init/exit
- remove useless variable in atmci_configure_dma function

Ludovic Desroches (4):
  mmc: atmel-mci: remove useless DMA stuff for non-dt devices
  mmc: atmel-mci: remove __init/__exit attributes
  mmc: atmel-mci: stop using specific initcall
  mmc: atmel-mci: use probe deferring if dma controller is not ready yet

 drivers/mmc/host/atmel-mci.c | 76 ++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 48 deletions(-)

-- 
2.0.3
