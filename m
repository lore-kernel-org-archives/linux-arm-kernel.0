From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Dec 2012 15:48:59 +0100
Subject: [PATCH v2] Device Tree binding for the mvsdio driver and related
 changes
Message-ID: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series of patches adds a Device Tree binding to the mvsdio driver
(the driver for the SDIO interface found in many Marvell SoCs), and
uses this binding to enable the SDIO interface on Armada 370 and
Armada XP platforms, as well as converting the Kirkwood platforms to
using the Device Tree to probe the SDIO interface.

The series has been tested on Kirkwood Topkick, Armada 370 Mirabox,
Armada XP OpenBlocks, Armada 370 DB and Armada XP DB. The changes on
the Dreamplug and MPLCEC4 boards should be tested by their respective
maintainers if possible.

This series is obviously 3.9 material.

Here is a short description of the patches:

 * Patches 1 and 2 cleanup the mvsdio driver initialization by using
   the slot-gpio helpers for the card-detect and write-protect GPIOs

 * Patch 3 adds the Device Tree binding itself to the mvsdio driver

 * Patch 4 adds pinctrl integration to the mvsdio driver

 * Patch 5 adds Device Tree information to describe the SDIO interface
   on the Armada 370 and Armada XP SoCs.

 * Patches 6 and 7 add pin muxing options for the SDIO interface on
   Armada 370 and Armada XP SoCs.

 * Patches 8, 9, 10 enable the SDIO interface on the Armada XP DB,
   Armada 370 DB and Globalscale Mirabox platforms.

 * Patch 11 adds Device Tree information to describe the SDIO
   interface on the Kirkwood SoCs.

 * Patches 12 and 13 convert the Dreamplug and mplcec4 Kirkwood
   platforms to use the Device Tree to probe their SDIO interface and
   mux the corresponding pins.

 * Patch 14 adds a pin mux option for the SDIO interface on the
   88F6282 SoC, which is used in the Topkick platform.

 * Patch 15 makes the Topkick DTS file inherit the kirkwood-8262.dtsi,
   so that it gets the pinctrl definition.

 * Patch 16 converts the Kirkwood Topkick platform to use the Device
   Tree to probe its SDIO interface and mux the corresponding pins.

 * Patch 17 removes a useless header inclusion related to the SDIO
   interface to the Kirkwood Dockstar platform.

 * Patches 18, 19 and 20 update the mvebu_defconfig to enable the
   mvsdio driver, as well as Wifi/Bluetooth drivers needed for the
   SD8787 chip connected over SDIO on the Globalscale Mirabox.

Changes since v1:

 * On Kirkwood Dreamplug, use the Device Tree to mux the SDIO pins,
   and remove a header inclusion that has become useless in the board
   C file. Requested by Andrew Lunn.

 * On Kirkwood MPLCEC4, use the Device Tree to mux the SDIO pins, and
   remove a header inclusion that has become useless in the board C
   file. Requested by Andrew Lunn.

 * Add a pin mux option for the SDIO interface in the 88F6282 SoC.

 * Make the Kirkwood Topkick DTS file inherit the 88F6282 DTSI file.

 * On Kirkwood Topkick, use the Device Tree to mux the SDIO pins, and
   remove a header inclusion that has become useless in the board C
   file. Requested by Andrew Lunn.

Best regards,

Thomas
