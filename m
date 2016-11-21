From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Nov 2016 11:23:12 +0100
Subject: [GIT PULL v2 9/10] arm64: tegra: Device tree changes for v4.10-rc1
In-Reply-To: <20161118161719.24153-9-thierry.reding@gmail.com>
References: <20161118161719.24153-9-thierry.reding@gmail.com>
Message-ID: <20161121102312.19968-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-arm64-dt-numeric-ids

for you to fetch changes up to 99575bceebd60b572f0ccf9a900fdb970922ca49:

  arm64: tegra: Add NVIDIA P2771 board support (2016-11-21 10:43:42 +0100)

The only change since the original pull request is the replacement of
symbolic names in DTS files by their numerical equivalents to remove the
dependency on the driver branchs, as requested by Olof.

I have three patches to reintroduce these symbols that I can resend after
v4.10-rc1.

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v4.10-rc1

This adds initial support for Tegra186, the P3310 processor module as
well as the P2771 development board. Not much is functional, but there
is enough to boot to an initial ramdisk with debug serial output.

----------------------------------------------------------------
Joseph Lo (3):
      arm64: tegra: Add Tegra186 support
      arm64: tegra: Add NVIDIA P3310 processor module support
      arm64: tegra: Add NVIDIA P2771 board support

Thierry Reding (6):
      arm64: tegra: Add CPU nodes for Tegra186
      arm64: tegra: Add serial ports on Tegra186
      arm64: tegra: Add I2C controllers on Tegra186
      arm64: tegra: Add SDHCI controllers on Tegra186
      arm64: tegra: Add GPIO controllers on Tegra186
      arm64: tegra: Enable PSCI on P3310

 arch/arm64/boot/dts/nvidia/Makefile                |   1 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   8 +
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |  64 ++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 398 +++++++++++++++++++++
 4 files changed, 471 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186.dtsi
