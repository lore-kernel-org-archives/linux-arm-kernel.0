From: stefan@agner.ch (Stefan Agner)
Date: Sat, 10 Jan 2015 01:08:57 +0100
Subject: [PATCH v2 0/2] serial: fsl_lpuart: fix DMA issues for 3.19
Message-ID: <1420848539-4519-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is patch 1 and 3 of the first version of this patchset.

Changes since v1:
- Reproduced on v3.19-rc3 and rebased ontop of that
- Make sure that RDMAS is cleared on startup

Stefan Agner (2):
  serial: fsl_lpuart: delete timer on shutdown
  serial: fsl_lpuart: avoid new transfer while DMA is running

 drivers/tty/serial/fsl_lpuart.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.2.1
