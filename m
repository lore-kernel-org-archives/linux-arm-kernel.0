From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Wed, 28 Sep 2011 11:20:06 +0530
Subject: [PATCH V2 0/1] dmaengine/amba-pl08x: Add support for s3c64xx DMAC
Message-ID: <1317189007-23033-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the amba-pl08x driver for s3c64xx.
The DMA controller of S3C64XX is a variant of PrimeCell pl080 DMAC.
S3C64xx contents extra register to hold the TransferSize.

Below diagram explains the s3c64xx LLI structure and offsets.
	-----------------------------------------------------------------
	|       Offset          |       Contents                        |
	-----------------------------------------------------------------
	| Next LLI Address      | Source Address for Next xfer          |
	----------------------------------------------------------------- 
	| Next LLI Address+0x04 | Destination Address for Next xfer     |
	-----------------------------------------------------------------
	| Next LLI Address+0x08 | Next LLI address for Next xfer        |
	-----------------------------------------------------------------
	| Next LLI Address+0x0c | DMACCxControl0 data for Next xfer     |
	-----------------------------------------------------------------
	| Next LLI Address+0x10 | DMACCxControl1 xfer size for Next xfer|
	----------------------------------------------------------------- 

Changes since v1:
	- Rebased with "samsung_dma" branch of 
	http://git.infradead.org/users/vkoul/slave-dma.git

	- Addressed review comments from linus.walleij 
	http://www.spinics.net/lists/arm-kernel/msg135411.html

Alim Akhtar (1):
  dmaengine/amba-pl08x: Add support for s3c64xx DMAC

 drivers/dma/amba-pl08x.c |  135 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 112 insertions(+), 23 deletions(-)

-- 
1.7.2.3
