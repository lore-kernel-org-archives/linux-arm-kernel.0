From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 17 Jun 2016 16:57:20 +0900
Subject: [PATCH 0/5] SPI CS line logical change and s3c64xx code rework
Message-ID: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the main goal of the patchset is to support SPI cnnected device
without CS line link.

The first patch removes two 'if' conditions in the spi core
framework, leaving this way the responsibility for checking
whether the CS line is connected to the specific SPI driver.
Because the spi core doesn't allow a disconnected CS line, the
drivers were assigning -1 or 255 as number of CS lines, which is
not correct also considering the variables type.

The second and third patches enable this case in the s3c64xx
driver.

The fourth and fith patches are code rework related to the
s3c64xx driver.

Andi

Andi Shyti (5):
  spi: do not fail if the CS line is not connected
  spi: s3c64xx: group the CS signalling writes in a single function
  spi: s3c64xx: consider the case where the CS line is not connected
  spi: s3c64xx: do not configure the device twice
  spi: s3c63xx: simplify if statement in prepare_transfer function

 drivers/spi/spi-s3c64xx.c | 104 ++++++++++++++++++++++++----------------------
 drivers/spi/spi.c         |  15 ++++---
 2 files changed, 62 insertions(+), 57 deletions(-)

-- 
2.8.1
