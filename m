From: hector.palacios@digi.com (Hector Palacios)
Date: Thu, 3 Oct 2013 09:32:02 +0200
Subject: [PATCH v3 0/2] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
Message-ID: <1380785524-20490-1-git-send-email-hector.palacios@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a bug whereby the AUART was shutdown while bytes
were still waiting in the DMA buffer to be transmistted.

Changes since v2:
 * Added Reviewed/Acked-by tags to first commit.
 * Move tx_empty callback up to avoid forward declaration.
 * Move BUSY flag check to tx_empty callback to avoid check
   on shutdown call.

Changes since v1:
 * Split the patch in two: one to set the fifosize to the
   DMA buffer size, and another to wait for the FIFO to empty
   before disabling the AUART.
 * The wait for the fifo to empty is now independent of DMA
   being enabled.
 * Fix bug on readl() call
 * Remove bad URL in commit log


Hector Palacios (2):
  serial: mxs-auart: set the FIFO size to DMA buffer size
  serial: mxs-auart: wait for FIFO to flush before shutdown

 drivers/tty/serial/mxs-auart.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

-- 
1.8.4
