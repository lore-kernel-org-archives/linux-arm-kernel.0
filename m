From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 16 Nov 2013 14:23:33 +0100
Subject: [PATCH 00/11]: add remaining support for IGEP boards
Message-ID: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to make mach-omap2 Device Tree only the board file for
IGEP boards was removed even when support for wifi and display
was still not supported by its DTS.

This patch-set adds support for these remaining peripherals and
also adds support for USB, HDMI and user LED for the am33xx SoC
based IGEP Aquila board.

The patch-set is composed of the following patches:

Enric Balletbo i Serra (7):
      ARM: dts: omap3-igep: Fix bus-width for mmc1.
      ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi connected to SDIO.
      ARM: dts: omap3-igep: Update to use the TI AM/DM37x processor.
      ARM: dts: AM33XX BASE0033: add pinmux and hdmi node to enable display
      ARM: dts: AM33XX BASE0033: add pinmux and user led support.
      ARM: dts: AM33XX BASE0033: add 32KBit EEPROM support.
      ARM: dts: AM33XX IGEP0033: add USB support.

Javier Martinez Canillas (4):
      ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices
      ARM: dts: omap3-igep0020: Add pinmuxing for DVI output
      ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus
      OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is not found

Tony,

Most of these patches are just DTS changes so they have to be picked
by Benoit although there are patches that should go to different trees.

[PATCH 10/11] ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus

have to go through your tree and

[PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is not found

should be picked by Tomi Valkeinen.

Since we have removed the board file for IGEP boards I think these
can be considered as regression fixes for 3.13 although I don't mind
if you prefer to wait for 3.14.

Thanks a lot and best regards,
Javier
