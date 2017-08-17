From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 17 Aug 2017 11:37:45 -0700
Subject: [GIT PULL 3/6] Broadcom devicetree-arm64 changes for 4.14
In-Reply-To: <20170817183748.1450-1-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
Message-ID: <20170817183748.1450-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/devicetree-arm64

for you to fetch changes up to 63b2ff6aa608297472313eee473c2df8b060d491:

  arm64: dts: Add SBA-RAID DT nodes for Stingray SoC (2017-08-07 10:30:14 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs Device Tree changes for
4.14, please pull the following:

- Scott moves all the Northstar 2 DTS files into a sub-directory to be consistent
  with what was done for stingray and to future proof the addition of new board
  DTS files

- Velibor adds the ARM CCN-502 interconnect DT node to the Stingray SoC
  DTS include file

- Srinath adds the MDIO multiplexer and SATA nodes to the Stingray DTS
  include files

- Anup adds the SP804 timers, FlexRM (mailbox) and RAID engine DT nodes
  to the Stingray DTS include files

- Abishek adds the BGMAC (Ethernet controller) node to the Stingray DTS
  files

----------------------------------------------------------------
Abhishek Shah (1):
      arm64: dts: Add DT node to enable BGMAC driver on Stingray

Anup Patel (3):
      arm64: dts: Add sp804 DT nodes for Stingray SoC
      arm64: dts: Add FlexRM DT nodes for Stingray
      arm64: dts: Add SBA-RAID DT nodes for Stingray SoC

Scott Branden (1):
      arm64: dts: move ns2 into northstar2 directory

Srinath Mannam (2):
      arm64: dts: Add MDIO multiplexer DT node for Stingray
      arm64: dts: Add SATA DT nodes for Stingray SoC

Velibor Markovski (1):
      arm64: dts: Enable stats for CCN-502 interconnect on Stingray

 arch/arm64/boot/dts/broadcom/Makefile              |   4 +-
 arch/arm64/boot/dts/broadcom/northstar2/Makefile   |   6 +
 .../dts/broadcom/{ => northstar2}/ns2-clock.dtsi   |   0
 .../boot/dts/broadcom/{ => northstar2}/ns2-svk.dts |   0
 .../boot/dts/broadcom/{ => northstar2}/ns2-xmc.dts |   0
 .../boot/dts/broadcom/{ => northstar2}/ns2.dtsi    |   0
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi |  78 ++++++
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |   4 +
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |   4 +
 .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   | 118 +++++++++
 .../boot/dts/broadcom/stingray/stingray-sata.dtsi  | 278 +++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 136 ++++++++++
 12 files changed, 626 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/northstar2/Makefile
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-clock.dtsi (100%)
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-svk.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-xmc.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2.dtsi (100%)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
