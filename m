From: b32955@freescale.com (Huang Shijie)
Date: Wed, 23 Apr 2014 18:16:48 +0800
Subject: [PATCH v1 0/7] mtd: spi-nor: Add the DDR quad read support
In-Reply-To: <a>
References: <a>
Message-ID: <1398248215-26768-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 (0) This patch set depends on the patch:
	http://lists.infradead.org/pipermail/linux-mtd/2014-April/053308.html

  
 (1) This patch set tries to add the DDR quad read support for the SPI
     NOR framework, and it also adds the DDR quad read support for FREESCALE
     quadspi controller driver.

 (2) Test this patch set with Spansion s25fl128s, the performance with mtd_speedtest.ko:
     =================================================
     mtd_speedtest: MTD device: 0
     mtd_speedtest: not NAND flash, assume page size is 512 bytes.
     mtd_speedtest: MTD device size 16777216, eraseblock size 65536, page size 512,
                    count of eraseblocks 256, pages per eraseblock 128, OOB size 0
     mtd_speedtest: testing eraseblock write speed
     mtd_speedtest: eraseblock write speed is 665 KiB/s
     mtd_speedtest: testing eraseblock read speed
     mtd_speedtest: eraseblock read speed is 49799 KiB/s
     mtd_speedtest: testing page write speed
     mtd_speedtest: page write speed is 662 KiB/s
     mtd_speedtest: testing page read speed
     mtd_speedtest: page read speed is 24236 KiB/s
     mtd_speedtest: testing 2 page write speed
     mtd_speedtest: 2 page write speed is 657 KiB/s
     mtd_speedtest: testing 2 page read speed
     mtd_speedtest: 2 page read speed is 32637 KiB/s
     mtd_speedtest: Testing erase speed
     mtd_speedtest: erase speed is 518 KiB/s
     mtd_speedtest: Testing 2x multi-block erase speed
     mtd_speedtest: 2x multi-block erase speed is 506 KiB/s
     mtd_speedtest: Testing 4x multi-block erase speed
     mtd_speedtest: 4x multi-block erase speed is 503 KiB/s
     mtd_speedtest: Testing 8x multi-block erase speed
     mtd_speedtest: 8x multi-block erase speed is 501 KiB/s
     mtd_speedtest: Testing 16x multi-block erase speed
     mtd_speedtest: 16x multi-block erase speed is 498 KiB/s
     mtd_speedtest: Testing 32x multi-block erase speed
     mtd_speedtest: 32x multi-block erase speed is 496 KiB/s
     mtd_speedtest: Testing 64x multi-block erase speed
     mtd_speedtest: 64x multi-block erase speed is 495 KiB/s
     mtd_speedtest: finished
     =================================================

  (3) Conclusion:
     The DDR quad read could be 49799 KiB/s.
     
Changlog:
  About this patch set:
     For patch 1, please see the old discusstion:
     http://lists.infradead.org/pipermail/linux-mtd/2014-April/053370.html

     For patch 2, please see the old discusstion:
     http://lists.infradead.org/pipermail/linux-mtd/2014-April/053374.html

     
Huang Shijie (7):
  mtd: spi-nor: fix the wrong dummy value
  mtd: spi-nor: add DDR quad read support
  Documentation: mtd: add a new document for SPI NOR flash
  Documentation: fsl-quadspi: update the document
  mtd: fsl-quadspi: get the dummy cycles for DDR Quad read from the DT
    property
  mtd: fsl-quadspi: use the information stored in spi-nor{}
  mtd: fsl-quadspi: add the DDR quad read support

 .../devicetree/bindings/mtd/fsl-quadspi.txt        |   16 +++
 .../devicetree/bindings/mtd/spi-nor-flash.txt      |    7 +
 drivers/mtd/devices/m25p80.c                       |    5 +-
 drivers/mtd/spi-nor/fsl-quadspi.c                  |  121 +++++++++++++-------
 drivers/mtd/spi-nor/spi-nor.c                      |   52 ++++++++-
 include/linux/mtd/spi-nor.h                        |    8 +-
 6 files changed, 162 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nor-flash.txt

-- 
1.7.2.rc3
