From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 14 Jul 2015 14:45:23 -0500
Subject: [PATCH 0/4] spi: davinci: Improve prescaler limit support
Message-ID: <1436903127-6777-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the prescale limit is treated as a one size fits all value even
though their are differences depending on the SOC. This patchset insures
that the proper prescale limit is used for each platform/SOC.

Franklin S Cooper Jr (4):
  spi: davinci: Set prescale value based on register value
  spi: davinci: Choose correct pre-scaler limit based on SOC
  ARM: davinci: Set proper SPI prescale limit value
  ARM: dts: keystone: Add ti,keystone-spi for SPI

 .../devicetree/bindings/spi/spi-davinci.txt        |  2 +
 arch/arm/boot/dts/keystone.dtsi                    |  6 +--
 arch/arm/mach-davinci/devices-da8xx.c              |  2 +
 arch/arm/mach-davinci/dm355.c                      |  1 +
 arch/arm/mach-davinci/dm365.c                      |  1 +
 drivers/spi/spi-davinci.c                          | 50 +++++++++++++++++-----
 include/linux/platform_data/spi-davinci.h          |  1 +
 7 files changed, 50 insertions(+), 13 deletions(-)

-- 
1.9.1
