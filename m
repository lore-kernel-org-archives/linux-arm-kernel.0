From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 14 Jul 2016 16:45:45 +0200
Subject: [GIT PULL 1/2] arm64: tegra: Device tree changes for v4.8-rc1
Message-ID: <20160714144546.29427-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-arm64-dt

for you to fetch changes up to 34993594181dc1b34eaf8e3b878dde5ed810e61f:

  arm64: tegra: Enable HDMI on Jetson TX1 (2016-07-14 16:20:27 +0200)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v4.8-rc1

A slew of updates for Tegra210 support: PMIC and regulator additions,
which in turn allow a bunch of features to be enabled. Some assemblies
of the Jetson TX1 come with a DSI panel that is now supported. For all
other assemblies, this set of changes enables the HDMI output. Jetson
TX1 can now also make use of the XUSB controller.

PMIC and regulator support is also added for Smaug, which will allow a
number of interesting feature additions in future releases.

----------------------------------------------------------------
Jon Hunter (5):
      arm64: tegra: Correct Tegra210 XUSB mailbox interrupt
      arm64: tegra: Add audio powergate node for Tegra210
      arm64: tegra: Add ACONNECT bus node for Tegra210
      arm64: tegra: Add DPAUX pinctrl bindings
      arm64: tegra: Add XUSB powergates on Tegra210

Rhyland Klein (1):
      arm64: tegra: Add regulators for Tegra210 Smaug

Thierry Reding (9):
      arm64: tegra: Add PMIC support on Jetson TX1
      arm64: tegra: p2597: Add SDMMC power supplies
      arm64: tegra: Add DSI panel on Jetson TX1
      arm64: tegra: Add Tegra210 XUSB pad controller
      arm64: tegra: Add Tegra210 XUSB controller
      arm64: tegra: Enable debug serial on Jetson TX1
      arm64: tegra: Enable XUSB controller on Jetson TX1
      arm64: tegra: Add sor1_src clock
      arm64: tegra: Enable HDMI on Jetson TX1

 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     | 249 ++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |  45 +++
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     | 319 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      | 314 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 292 ++++++++++++++++++-
 5 files changed, 1218 insertions(+), 1 deletion(-)
