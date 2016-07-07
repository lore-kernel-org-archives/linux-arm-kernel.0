From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  6 Jul 2016 20:36:11 -0700
Subject: [GIT PULL 3/4] Broadcom ARM64 Device Tree changes for 4.8 (part 2)
In-Reply-To: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
References: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1467862574-6522-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5dcc9c7618dff61de243ca9bbac7de18ef92f49b:

  arm64: dts: NS2: Add CCI-400 PMU support (2016-05-31 11:00:28 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/devicetree-arm64-part2

for you to fetch changes up to b2aa1bb2be9c9cf4727ddb81ae1d0ad5a0c683a8:

  Merge tag 'bcm2835-dt-64-next-2016-07-03' into devicetree-arm64/next (2016-07-05 20:47:49 -0700)

----------------------------------------------------------------
This pull request contains the second part of the Broadcom ARM64-based SoCs
changes for 4.8. Please note that this pull request contains changes from the
ARM 32-bits port and ARM 64-bits port as well:

- Lubomir updates all BCM2835 (Raspberry Pi family) Device Tree source files with
  their proper information about the on-board USB Ethernet adapter so there is
  appropriate binding between this USB device and a device_node (useful for MAC
  address fetching and stuff), this commit is also present for the ARM DT pull
  request

- Eric adds support for the Raspberry Pi 3 aka BCM2837 and provides the binding
  information and the basic SoC DT include file required to boot to a prompt

- Gerd updates the Raspberry Pi 3 DT with Ethernet information based on the
  earlier change from Lubomir

----------------------------------------------------------------
Eric Anholt (3):
      dt-bindings: Add root properties for Raspberry Pi 3
      ARM: bcm2835: Add devicetree for the Raspberry Pi 3.
      Merge tag 'bcm2835-dt-ethernet' into HEAD

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-64-next-2016-07-03' into devicetree-arm64/next

Gerd Hoffmann (1):
      ARM: bcm2837: dt: Add the ethernet to the device trees

Lubomir Rintel (1):
      ARM: bcm2835: dt: Add the ethernet to the device trees

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  1 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  1 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi        | 19 ++++++
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi        | 19 ++++++
 arch/arm/boot/dts/bcm283x.dtsi                     |  2 +
 arch/arm64/boot/dts/broadcom/Makefile              |  1 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   | 30 +++++++++
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          | 76 ++++++++++++++++++++++
 11 files changed, 155 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837.dtsi
