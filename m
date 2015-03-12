From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Mar 2015 14:13:41 +0100
Subject: [PATCH RFC 0/3] ARM: sunxi: SRAM mapping support
Message-ID: <1426166024-24922-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The Allwinner SoCs all have a bunch of SRAMs (the exact number
depending on the SoC itself) that can all be mapped to the CPU or to a
bunch of devices, each SRAM having different possible devices to be
mapped to.

Since this SRAM setup is highly SoC dependant, relying on syscon would
put to much duplicated logic to devices that are using these SRAMs,
among which the USB OTG and EMAC controllers.

Here is an RFC to introduce a custom API to control the mapping of
these SRAM, ideally in a SoC-independant way.

Let me know what you think,
Maxime

Maxime Ripard (3):
  drivers: soc: sunxi: Introduce SoC driver to map SRAMs
  ARM: sun7i: Add A20 SRAM and SRAM controller
  net: allwinner: emac: Claim our SRAM

 arch/arm/boot/dts/sun7i-a20.dtsi            |  31 +++-
 drivers/net/ethernet/allwinner/sun4i-emac.c |  13 +-
 drivers/soc/Kconfig                         |   1 +
 drivers/soc/Makefile                        |   1 +
 drivers/soc/sunxi/Kconfig                   |  12 ++
 drivers/soc/sunxi/Makefile                  |   1 +
 drivers/soc/sunxi/sunxi_sram.c              | 234 ++++++++++++++++++++++++++++
 include/linux/soc/sunxi/sunxi_sram.h        |  24 +++
 8 files changed, 314 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soc/sunxi/Kconfig
 create mode 100644 drivers/soc/sunxi/Makefile
 create mode 100644 drivers/soc/sunxi/sunxi_sram.c
 create mode 100644 include/linux/soc/sunxi/sunxi_sram.h

-- 
2.3.1
