From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Jul 2017 20:13:17 +0100
Subject: [PATCH 0/6] Macchiatobin updates
Message-ID: <20170708191317.GM4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series, based upon the 4.12-rc6 backports branch in the MISL tree:
- adds a maintainer entry for the Macchiatobin board.
- adds GPIO interrupt support to the CP110s
- adds the pinmux entries
- corrects the 5V regulator GPIO entry
- adds support for the I2C mux (used for the SFP slots)
- adds PCIe support

All entries include the appropriate pinmux and GPIO configuration.

PCIe support has not been tested locally as I have no PCIe cards to
test with; this patch includes support for the PCIe reset GPIO signal.
If others can test that patch and let me know whether it works, I would
be most grateful.

 MAINTAINERS                                        |  6 ++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 89 +++++++++++++++++++++-
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 11 ++-
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 11 ++-
 4 files changed, 112 insertions(+), 5 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
