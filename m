From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 15:16:16 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.19
Message-ID: <20180724131616.brtatxqutdjd4oxt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-drivers-for-4.19

for you to fetch changes up to 7377330a1ed2e9bb5a97758bdadcdb37e2201b2a:

  soc: sunxi: Add the A13, A23 and H3 system control compatibles (2018-07-19 16:39:12 +0200)

----------------------------------------------------------------
Allwinner drivers changes for 4.19

There's been work for this release cycles in both the SRAM controller
driver in order to support more SoCs, as part of our VPU work, but also to
enable the EMAC on the A64 (that needs to poke at registers within the same
register space).

Some work has been needed too to represent the bus to the display engine
controllers that all need an SRAM to be mapped to the CPU to be able to
access those controllers' registers.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      dt-bindings: sram: Rename A64 SRAM controller compatible
      soc: sunxi: sram: Add updated compatible string for A64 system control

Icenowy Zheng (3):
      soc: sunxi: export a regmap for EMAC clock reg on A64
      dt-bindings: add binding for the Allwinner A64 DE2 bus
      bus: add bus driver for accessing Allwinner A64 DE2

Maxime Ripard (2):
      drivers: soc: sunxi: Add support for the C1 SRAM region
      soc: sunxi: Add the A13, A23 and H3 system control compatibles

Paul Kocialkowski (4):
      dt-bindings: sram: sunxi: Introduce new A10 binding for system-control
      soc: sunxi: sram: Add dt match for the A10 system-control compatible
      dt-bindings: sram: sunxi: Add A13, A20, A23 and H3 dedicated bindings
      dt-bindings: sram: sunxi: Populate valid sections compatibles

 .../devicetree/bindings/bus/sun50i-de2-bus.txt     | 37 +++++++++
 .../devicetree/bindings/sram/sunxi-sram.txt        | 31 +++++++-
 drivers/bus/Kconfig                                | 10 +++
 drivers/bus/Makefile                               |  1 +
 drivers/bus/sun50i-de2.c                           | 48 ++++++++++++
 drivers/soc/sunxi/sunxi_sram.c                     | 87 +++++++++++++++++++++-
 6 files changed, 208 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
 create mode 100644 drivers/bus/sun50i-de2.c

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/92a3ba20/attachment.sig>
