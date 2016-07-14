From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 14 Jul 2016 16:45:46 +0200
Subject: [GIT PULL 2/2] arm64: tegra: Enable GPU on Jetson TX1
In-Reply-To: <20160714144546.29427-1-thierry.reding@gmail.com>
References: <20160714144546.29427-1-thierry.reding@gmail.com>
Message-ID: <20160714144546.29427-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-gm20b

for you to fetch changes up to 8a4383d0d71df2bc03251124bc7b6694f994a6ae:

  arm64: tegra: Add VDD_GPU regulator to Jetson TX1 (2016-07-14 16:38:14 +0200)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Enable GPU on Jetson TX1

This pulls in PWM regulator driver changes needed in order to enable the
GPU on Jetson TX1, adds the regulator to the device tree and hooks it up
to the GPU.

----------------------------------------------------------------
Alexandre Courbot (2):
      regulator: pwm: Support for enable GPIO
      arm64: tegra: Add VDD_GPU regulator to Jetson TX1

Boris Brezillon (1):
      regulator: pwm: Drop unneeded pwm_enable() call

Thierry Reding (3):
      Merge tag 'regulator-pwm-enable' of git://git.kernel.org/.../broonie/regulator into for-4.8/gm20b
      arm64: tegra: Add PMIC support on Jetson TX1
      Merge branch 'for-4.8/arm64/dt' into for-4.8/gm20b

 .../bindings/regulator/pwm-regulator.txt           |   7 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     | 263 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |  55 +++++
 drivers/regulator/pwm-regulator.c                  |  31 ++-
 4 files changed, 350 insertions(+), 6 deletions(-)
