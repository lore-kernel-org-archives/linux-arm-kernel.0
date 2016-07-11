From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 11 Jul 2016 17:25:11 +0200
Subject: [GIT PULL 3/4] arm64: tegra: Device tree changes for v4.8-rc1
In-Reply-To: <20160711152512.11731-1-thierry.reding@gmail.com>
References: <20160711152512.11731-1-thierry.reding@gmail.com>
Message-ID: <20160711152512.11731-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-arm64-dt

for you to fetch changes up to 52a2c7c9b0363658ca960ca596ef41ca930d0190:

  arm64: tegra: Add VDD_GPU regulator to Jetson TX1 (2016-07-01 16:22:23 +0200)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v4.8-rc1

A slew of updates for Tegra210 support: PMIC and regulator additions,
which in turn allow a bunch of features to be enabled. Some assemblies
of the Jetson TX1 come with a DSI panel that is now supported. For all
other assemblies, this set of changes enables the HDMI output. Jetson
TX1 can now also make use of the XUSB controller, and provided that it
is supported by the bootloader, the GPU can also be enabled.

PMIC and regulator support is also added for Smaug, which will allow a
number of interesting feature additions in future releases.

----------------------------------------------------------------
Alexandre Courbot (2):
      regulator: pwm: Support for enable GPIO
      arm64: tegra: Add VDD_GPU regulator to Jetson TX1

Boris Brezillon (1):
      regulator: pwm: Drop unneeded pwm_enable() call

Jon Hunter (5):
      arm64: tegra: Correct Tegra210 XUSB mailbox interrupt
      arm64: tegra: Add audio powergate node for Tegra210
      arm64: tegra: Add ACONNECT bus node for Tegra210
      arm64: tegra: Add DPAUX pinctrl bindings
      arm64: tegra: Add XUSB powergates on Tegra210

Rhyland Klein (1):
      arm64: tegra: Add regulators for Tegra210 Smaug

Thierry Reding (10):
      Merge tag 'regulator-pwm-enable' of git://git.kernel.org/.../broonie/regulator into HEAD
      arm64: tegra: Add PMIC support on Jetson TX1
      arm64: tegra: p2597: Add SDMMC power supplies
      arm64: tegra: Add DSI panel on Jetson TX1
      arm64: tegra: Add Tegra210 XUSB pad controller
      arm64: tegra: Add Tegra210 XUSB controller
      arm64: tegra: Enable debug serial on Jetson TX1
      arm64: tegra: Enable XUSB controller on Jetson TX1
      arm64: tegra: Add sor1_src clock
      arm64: tegra: Enable HDMI on Jetson TX1

 .../bindings/regulator/pwm-regulator.txt           |   7 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     | 267 +++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |  45 +++
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     | 319 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      | 314 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 292 ++++++++++++++++++-
 drivers/regulator/pwm-regulator.c                  |  31 +-
 7 files changed, 1268 insertions(+), 7 deletions(-)
