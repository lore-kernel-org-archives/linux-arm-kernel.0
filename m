From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 24 Oct 2011 16:33:18 +0200
Subject: [PATCH 0/2] mmc: mmci: Improvements for SDIO
Message-ID: <1319466800-19884-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the ux500v2 variant of the PL18x block, non power of two block
sizes are now supported.

In addition constraints on buffer alignments is needed since access to the
PL18x FIFO must be done on a 4-byte aligned manner. Moreover to be able to
use DMA for buffers with not 32 bytes aligned sg element lengths, DMAREQCTL
must enabled.

Per Forlin (1):
  mmc: mmci: add constraints on alignment for SDIO

Stefan Nilsson XK (1):
  mmc: mmci: Support non-power-of-two block sizes for ux500v2 variant

 drivers/mmc/host/mmci.c |   56 +++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/mmci.h |    7 ++++++
 2 files changed, 56 insertions(+), 7 deletions(-)

-- 
1.7.5.4
