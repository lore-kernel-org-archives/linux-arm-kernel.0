From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Jul 2018 07:38:19 -0700
Subject: [GIT PULL 4/6 v2] Broadcom devicetree-arm64 changes for 4.19
In-Reply-To: <20180713143821.1514-1-f.fainelli@gmail.com>
References: <20180713143821.1514-1-f.fainelli@gmail.com>
Message-ID: <20180713143821.1514-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/devicetree-arm64

for you to fetch changes up to e28e681630079204d6d2cb3da1e2c067d21eff64:

  arm64: dts: stingray: add bcm958802a802x dts (2018-07-13 07:24:26 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs Device Tree changes
for 4.19, please pull the following:

- Scott does a bunch of updates to the Stingray DTS and DTS include
  files to better support the addition of new boards. Scott also adds
  the Stingray OTP Device Tree node

- Pramod updates the Stingray clocks such that they match the latest
  revision of the ASIC and datasheets

- Ray sets the Stingray initial watchdog timeout to 60 seconds to give
  sufficient time for the kernel to boot and then adds PAXC (internal
  PCIe) support to the Stingray base DTS files

- Vladimir adds support for the Stingray smart NIC PS225 boards variants

----------------------------------------------------------------
Pramod Kumar (1):
      arm64: dts: Update Stingray clock DT nodes

Ray Jui (2):
      arm64: dts: set initial SR watchdog timeout to 60 seconds
      arm64: dts: stingray: add PAXC support

Scott Branden (2):
      arm64: dts: stingray: move common board components to stingray-board-base
      arm64: dts: stingray: Add OTP device node

Vladimir Olovyannikov (1):
      arm64: dts: stingray: add bcm958802a802x dts

 arch/arm64/boot/dts/broadcom/stingray/Makefile     |  2 +
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 35 +-------------
 .../boot/dts/broadcom/stingray/bcm958802a802x.dts  | 26 +++++++++++
 .../dts/broadcom/stingray/stingray-board-base.dtsi | 51 ++++++++++++++++++++
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi | 26 ++++++++---
 .../boot/dts/broadcom/stingray/stingray-pcie.dtsi  | 54 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 19 ++++++++
 7 files changed, 172 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi
