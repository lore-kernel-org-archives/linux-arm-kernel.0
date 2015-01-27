From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Tue, 27 Jan 2015 16:27:17 +0530
Subject: [PATCH 0/7] Add SPI support for Colibri modules and DSPI driver fixes
Message-ID: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Add second dspi instance.
- Enable MCP2515 CAN controller which is avaialble on
  Colibri evaluation board.

- Respin the stalled patches of dspi fixes.
  Previous discussion at:
  http://comments.gmane.org/gmane.linux.ports.arm.kernel/359542

Bhuvanchandra DV (4):
  ARM: vf610: add second DSPI instance
  ARM: vf-colibri: add SPI support and enable MCP2515 CAN
  spi: spi-fsl-dspi: Remove usage of devm_kalloc
  spi: spi-fsl-dspi: avoid preparing the clocks two times

Chao Fu (3):
  spi: spi-fsl-dspi: Remove spi-bitbang
  spi: spi-fsl-dspi: split the resuable code
  spi: spi-fsl-dspi: Add support for TCFQ transfer mode

 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |   2 +
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  31 ++
 arch/arm/boot/dts/vf-colibri.dtsi                  |  15 +
 arch/arm/boot/dts/vf500.dtsi                       |   4 +
 arch/arm/boot/dts/vfxxx.dtsi                       |  11 +
 drivers/spi/Kconfig                                |   1 -
 drivers/spi/spi-fsl-dspi.c                         | 314 +++++++++++++--------
 7 files changed, 254 insertions(+), 124 deletions(-)

-- 
2.2.2
