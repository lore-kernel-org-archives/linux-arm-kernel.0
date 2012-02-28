From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 28 Feb 2012 23:19:05 +0100
Subject: [PATCH v2 0/5] spi/omap: Adaptation to Device Tree
Message-ID: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Here are a couple of SPI patches + the addition of a SPI ethernet device
needed for sdp4430 board.

This update, compared to [1], is adding an extra cleanup to avoid relying
on bus_number in the code.
I changed as well the node name in the DTS  to spi at address to be compliant
with DT conventions.

If you are fine with that I'll send you a pull request for the spi driver
code only and I'll send the DTS stuff through Tony to avoid any conflicts.

This series is based on 3.3-rc4.

This series is available here for reference:
  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_spi_eth

Regards,
Benoit

[1] http://www.spinics.net/lists/linux-omap/msg64701.html


Benoit Cousson (5):
  spi/omap: Remove bus_num usage for instance index
  spi/omap: Add DT support to McSPI driver
  arm/dts: OMAP4: Add SPI controller nodes
  arm/dts: OMAP3: Add SPI controller nodes
  arm/dts: omap4-sdp: Add ks8851 ethernet SPI device

 Documentation/devicetree/bindings/spi/omap-spi.txt |   20 +++
 arch/arm/boot/dts/omap3.dtsi                       |   32 +++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   30 ++++--
 arch/arm/boot/dts/omap4.dtsi                       |   32 +++++
 arch/arm/mach-omap2/devices.c                      |    4 +-
 drivers/spi/spi-omap2-mcspi.c                      |  127 +++++++++++++-------
 6 files changed, 189 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/omap-spi.txt
