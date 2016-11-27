From: naga.sureshkumar.relli@xilinx.com (Naga Sureshkumar Relli)
Date: Sun, 27 Nov 2016 14:03:18 +0530
Subject: [LINUX RFC v4 0/4] Add stripe support for ZynqMP SoC GQSPI controller
Message-ID: <1480235598-33827-1-git-send-email-nagasure@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is continuation to previous patches mentioned in below link
http://marc.info/?l=linux-spi&m=145009963109143&w=2

i am re-initiating this series, Could you please help us to get this done?

what is dual parallel mode?
---------------------------
ZynqMP GQSPI controller supports Dual Parallel mode with following functionalities:
1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
2) Chip selects, data lines and clock are differ to both the flash devices
3) This mode is targeted for faster read/write speed and also doubles the size
4) Commands/data can be transmitted/received from both the devices(mirror),
   or only upper or only lower flash memory devices.
5) Data arrangement:
   With stripe enabled,
   Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
   Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.

i have tested this on top of latest git-hub master.
kindly suggest us the way, so that we can proceed further to add this support.

Naga Sureshkumar Relli (4):
  spi: adding support for data stripe feature in core
  mtd: add spi_device instance to spi_nor struct
  mtd: spi-nor: add stripe support
  spi: zynqmp: gqspi: add support for stripe feature

 drivers/mtd/devices/m25p80.c   |   1 +
 drivers/mtd/spi-nor/spi-nor.c  | 130 ++++++++++++++++++++++++++++++++---------
 drivers/spi/spi-zynqmp-gqspi.c |  26 ++++++++-
 drivers/spi/spi.c              |   8 +++
 include/linux/mtd/spi-nor.h    |   3 +
 include/linux/spi/spi.h        |  11 ++++
 6 files changed, 149 insertions(+), 30 deletions(-)

-- 
2.10.2
