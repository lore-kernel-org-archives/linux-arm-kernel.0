From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 5 Apr 2013 15:30:16 +0530
Subject: [GIT PULL 2/3] DaVinci DT updates for v3.10
In-Reply-To: <1365156017-12149-1-git-send-email-nsekhar@ti.com>
References: <1365156017-12149-1-git-send-email-nsekhar@ti.com>
Message-ID: <1365156017-12149-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are the DT updates for v3.10. This depends on the
SoC updates from previous pull request.

Thanks,
Sekhar

The following changes since commit 93bd65150e4ee783b7366fd0e8172f347515df61:

  ARM: davinci: remove test for undefined Kconfig macro (2013-04-03 09:43:08 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.10/dt

for you to fetch changes up to db4c8fa7c0214c83cbbc990ba630b3b613fcf7c5:

  ARM: davinci: da850: override mmc DT node device name (2013-04-04 16:58:10 +0530)

----------------------------------------------------------------
v3.10 DT updates for DaVinci

The pull request adds support for MMC/SD and regulator on DA850 EVM.

----------------------------------------------------------------
Manjunathappa, Prakash (3):
      mmc: davinci_mmc: add DT support
      ARM: davinci: da850: add mmc DT entries
      ARM: davinci: da850: override mmc DT node device name

Vishwanathrao Badarkhe, Manish (2):
      ARM: regulator: add tps6507x device tree data
      ARM: davinci: da850: add tps6507x regulator DT data

 .../devicetree/bindings/mmc/davinci_mmc.txt        |   33 +++++++++
 arch/arm/boot/dts/da850-evm.dts                    |   70 ++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi                       |   15 +++++
 arch/arm/boot/dts/tps6507x.dtsi                    |   47 +++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c                   |    1 +
 drivers/mmc/host/davinci_mmc.c                     |   70 ++++++++++++++++++--
 6 files changed, 232 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt
 create mode 100644 arch/arm/boot/dts/tps6507x.dtsi
