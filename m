From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 22 Nov 2016 12:31:29 +0530
Subject: [PATCH v3 0/3] Fixes for Vybrid SPI DMA implementation
Message-ID: <cover.1479796821.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This v3 set of patches have fixes for Vybrid SPI DMA
implementation and is rebased on top of latest topic/fsl-dspi. 

http://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/log/?h=topic/fsl-dspi

The patches have been tested on a Toradex Colibri Vybrid VF61 module
and now incoporate feedback from Stefan on version 2 of patchset.

Changes since v2:
1. Drop the patch "Fix SPI transfer issue when using multiple SPI_IOC_MESSAGE"
since it's now applied and rebase the whole patchset
2. Second patch in this series "Fix continuous selection format" now
fixes the issue using an existing function and handling it similar to
existing EOQ mode and also cleaning up nicely the transmit code path.
3. Third patch now just fixes the incorrect freeing of DMA allocated buffers
and drops the minor clean up patch from earlier series completely due to
the clean up from 2 above.

Changes since v1:
1. Place the continuous selection format patch second in order and remove
code duplication
2. Improve the use of curr_xfer_len and instead of converting from bytes
to DMA transfers in every use, do it at a single place. Accordingly change
it's use at other places
3. Code cleanup patch has less to clean with change above

v2:
https://www.spinics.net/lists/arm-kernel/msg543941.html

v1:
http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1274632.html

Thanks & Regards,
Sanchayan.

Sanchayan Maity (3):
  spi: spi-fsl-dspi: Fix incorrect DMA setup
  spi: spi-fsl-dspi: Fix continuous selection format
  spi: spi-fsl-dspi: Fix incorrect freeing of DMA allocated buffers

 drivers/spi/spi-fsl-dspi.c | 59 +++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

-- 
2.10.2
