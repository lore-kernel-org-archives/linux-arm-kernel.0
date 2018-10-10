From: kernel@esmil.dk (Emil Renner Berthing)
Date: Wed, 10 Oct 2018 11:00:31 +0200
Subject: [PATCH 0/7] Enable spi dma on Rockchip RK3399
Message-ID: <20181010090038.20834-1-kernel@esmil.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The first three patches in this series enable spi dma on rk3399,
while the remaining patches are meant to be decreasingly obvious
cleanups to the rockchip spi driver.

Unfortunately I only have rk3399-gru-kevin hardware to test
this on, so it would be nice if someone would test this on
other rockchips.

/Emil

Emil Renner Berthing (5):
  arm64: dts: rockchip: add rk3399 SPI DMAs
  spi: rockchip: remove unneeded dma_caps
  spi: rockchip: mark use_dma as bool
  spi: rockchip: directly use direction constants
  spi: rockchip: simplify spi enable logic

Huibin Hong (2):
  spi: rockchip: initialize dma_slave_config properly
  spi: rockchip: adjust dma watermark and burstlen

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++
 drivers/spi/spi-rockchip.c               | 62 +++++++++---------------
 2 files changed, 32 insertions(+), 40 deletions(-)

-- 
2.19.1
