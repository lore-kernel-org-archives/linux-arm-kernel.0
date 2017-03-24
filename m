From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Mar 2017 10:58:02 -0700
Subject: [GIT PULL 2/7] Broadcom devicetree changes for 4.12
In-Reply-To: <20170324175807.27272-1-f.fainelli@gmail.com>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
Message-ID: <20170324175807.27272-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/devicetree

for you to fetch changes up to 414ce21ae20547e0eea72fe0c4e8ee3280d30888:

  Merge tag 'bcm2835-dt-next-2017-03-21' into devicetree/next (2017-03-24 10:12:31 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree updates for
4.12, please pull the following:

- Rafal:

	* adds basic support for the Linksys EA9200, Linksys EA6300 V1, Linksys
	  EA9500, TP-Link Archer C5 V2 which are all based on BCM470x SoCs with
	  a bunch of BCM43602 radios.

	* updates the BCM5301X DTS and DTS include file and moves the serial
	  console parameters to the DTS include file since all BCM5301X that we have so
	  far are consistent in using the same UART. He also does the same for the
	  BCM53573 DTS.

	* makes some updates to the Tenda AC9 platform by describing its
	  PCIe controllers and endpoints in order to be able to represent GPIOs attached
	  to the on-chip Wi-Fi module. Once done, he adds the 2Ghz LED which is connected
	  to one of these GPIOs.

	* re-licenses the DTS files he created to the ISC license

	* removes the use of the non-existend "default-off" LED trigger in the
	  BCM53573 and BCM5301X DTS files

- Aditya adds missing Netgear R8000 LEDS and keys for WAN status LEDS and brightness

- Jon:
	* adds NAND controller Device Tree nodes to the BCM953012K reference board

  	* converts the BCM5301X SoC to use the recently introduced Broadcom QSPI controller
  	  Device Tree nodes.

	* fixes the GIC PPI interrupt flags that the kernel now
  	  reports about.

	* adds ARM TWD watchdog entries to the BCM5301X DTS include file
  	* adds I2C entries to the BCM5301X DTS include files.

	* disables i2c by default in the Northstar Plus DTS include file, and
	 ,enables it at the board level instead.

	* adds USB (OHCI & EHCI) Device Tree nodes to the Northstar Plus DTS
	  include files.

- Steven adds the mailbox (PDC) unit and the crytographic unit (SPU) to the
  Broadcom Northstar Plus SoC DTS include file. Steven also adds proper ethernet
  aliases to the BCM53012HR board since some bootloaders require that for MAC address
  patching.

- Eric adds the DSI and its corresponding clock nodes to the BCM283x DTS files
  but leaves them disabled by default (overlays should take care of enabling it)

- Boris adds support for HDMI audio and related DMA channels to the BCM283x SoCs

- Gerd adds support for the BCM2835 specific SDHCI controller to the BCM283x SoCs

- Rob fixes the iProc msi-controller name and unit address now that DTC can produce
  additional errors

----------------------------------------------------------------
Aditya Xavier (1):
      ARM: dts: BCM5301X: Add missing Netgear R8000 LEDs and Keys

Boris Brezillon (1):
      ARM: dts: bcm283x: Add HDMI audio related properties

Eric Anholt (1):
      ARM: dts: bcm2835: Add the DSI module nodes and clocks.

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2017-03-21' into devicetree/next

Gerd Hoffmann (1):
      ARM: dts: bcm2835: add sdhost controller to devicetree

Jon Mason (7):
      ARM: dts: BCM5301X: Add NAND entries to bcm953012k
      ARM: dts: BCM5301X: convert to iProc QSPI
      ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags
      ARM: dts: BCM5301X: Add TWD WD Support to DT
      ARM: dts: BCM5301X: Add I2C support to the DT
      ARM: dts: NSP: Add EHCI/OHCI USB nodes to device tree
      ARM: dts: NSP: disable i2c DT entry by default

Rafa? Mi?ecki (11):
      ARM: dts: BCM5301X: Add basic DT for Linksys EA9200
      ARM: dts: BCM5301X: Add basic DT for Linksys EA6300 V1
      ARM: dts: BCM5301X: Add basic DT for Linksys EA9500
      ARM: dts: BCM53573: Describe Tenda AC9 PCIe card in DT
      ARM: dts: BCM53573: Add Tenda AC9 2 GHz LED
      ARM: dts: BCM5301X: Relicense DTS files I created to the ISC
      ARM: dts: BCM53573: Don't use nonexistent "default-off" LED trigger
      ARM: dts: BCM5301X: Don't use nonexistent "default-off" LED trigger
      ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
      ARM: dts: BCM5301X: Specify serial console params in dtsi files
      ARM: dts: BCM53573: Specify serial console parameters

Rob Herring (1):
      ARM: dts: bcm: fix msi-controller name and unit address

Steve Lin (4):
      ARM: dts: BCM5301X: Add support for BCM953012HR
      ARM: dts: BCM953012HR: Add ethernet aliases
      ARM: dts: NSP: Add mailbox (PDC) to NSP
      ARM: dts: NSP: Add crypto (SPU) to dtsi

 arch/arm/boot/dts/Makefile                         |  5 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  4 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     | 36 +++++++-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 | 14 ++++
 arch/arm/boot/dts/bcm283x.dtsi                     | 60 ++++++++++++-
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        | 17 ++--
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        | 14 +++-
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |  5 --
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts    | 41 +++++++++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        |  3 -
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     | 15 +++-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 10 ---
 arch/arm/boot/dts/bcm4708.dtsi                     |  8 ++
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        | 14 +++-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 16 ++--
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  | 12 ++-
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts | 98 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm47081.dtsi                    | 20 ++++-
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        | 14 +++-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |  8 --
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts       | 42 ++++++++++
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        | 19 +++--
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        | 41 ++++++---
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |  8 --
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      | 18 ++--
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts    | 36 ++++++++
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |  8 --
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |  6 --
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts           | 39 ++++++++-
 arch/arm/boot/dts/bcm5301x.dtsi                    | 81 +++++++++++++-----
 arch/arm/boot/dts/bcm53573.dtsi                    | 10 ++-
 arch/arm/boot/dts/bcm94708.dts                     |  8 --
 arch/arm/boot/dts/bcm94709.dts                     |  8 --
 arch/arm/boot/dts/bcm953012er.dts                  |  8 --
 arch/arm/boot/dts/bcm953012hr.dts                  | 97 +++++++++++++++++++++
 arch/arm/boot/dts/bcm953012k.dts                   | 62 +++++++++++++-
 arch/arm/boot/dts/bcm958522er.dts                  | 10 ++-
 arch/arm/boot/dts/bcm958525er.dts                  | 10 ++-
 arch/arm/boot/dts/bcm958525xmc.dts                 | 10 +++
 arch/arm/boot/dts/bcm958622hr.dts                  | 10 ++-
 arch/arm/boot/dts/bcm958623hr.dts                  | 10 ++-
 arch/arm/boot/dts/bcm958625hr.dts                  |  8 ++
 arch/arm/boot/dts/bcm958625k.dts                   |  8 ++
 arch/arm/boot/dts/bcm988312hr.dts                  | 10 ++-
 44 files changed, 814 insertions(+), 167 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
 create mode 100644 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
 create mode 100644 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-linksys-panamera.dts
 create mode 100644 arch/arm/boot/dts/bcm953012hr.dts
