From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:33:45 +0100
Subject: Device Tree binding for the mvsdio driver and related changes
Message-ID: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series of patches adds a Device Tree binding to the mvsdio driver
(the driver for the SDIO interface found in many Marvell SoCs), and
uses this binding to enable the SDIO interface on Armada 370 and
Armada XP platforms, as well as converting the Kirkwood platforms to
using the Device Tree to probe the SDIO interface.

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

 * Patches 12, 13, 14 convert the Kirkwood platforms that have been
   migrated to the Device Tree, to actually use the Device Tree to
   probe the SDIO interface.

 * Patch 15 removes a useless header inclusion related to the SDIO
   interface to the Kirkwood Dockstar platform.

 * Patches 16, 17 and 18 update the mvebu_defconfig to enable the
   mvsdio driver, as well as Wifi/Bluetooth drivers needed for the
   SD8787 chip connected over SDIO on the Globalscale Mirabox.

Best regards,

Thomas
