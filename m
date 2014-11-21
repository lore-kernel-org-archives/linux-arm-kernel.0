From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 21 Nov 2014 16:33:34 +0100
Subject: [PATCH v2 0/4] mmc: atmel-mci: cleanup and probe deferring
Message-ID: <1416584018-8561-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some cleanup to introduce probe deferring if dma controller is not probed.

The purpose of this second version is to have the __init/__exit attributes
removal in a patch that can be backported into stable kernels.

Ludovic Desroches (4):
  mmc: atmel-mci: remove useless DMA stuff for non-dt devices
  mmc: atmel-mci: remove __init/__exit attributes
  mmc: atmel-mci: stop using specific initcall
  mmc: atmel-mci: use probe deferring if dma controller is not ready yet

 drivers/mmc/host/atmel-mci.c | 75 ++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

-- 
2.0.3
