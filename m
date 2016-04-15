From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 Apr 2016 16:42:03 +0200
Subject: [GIT PULL 3/3] arm64: tegra: Changes for v4.7-rc1
In-Reply-To: <1460731323-31001-1-git-send-email-thierry.reding@gmail.com>
References: <1460731323-31001-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1460731323-31001-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-arm64

for you to fetch changes up to 8d53957c66e5cc0f1e8d33807800271d0f4fa009:

  arm64: tegra: Enable cros-ec and charger on Smaug (2016-04-15 15:36:38 +0200)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Changes for v4.7-rc1

A couple of cleanups and fixes to various device trees, enable power and
volume keys on Jetson TX1, use stdout-path to define the serial port (so
it doesn't have to be specified on the kernel command-line) and add
Google Pixel C (a.k.a. Smaug) support.

----------------------------------------------------------------
Jon Hunter (3):
      arm64: tegra: Add support for Google Pixel C
      arm64: tegra: Remove unused #power-domain-cells property
      arm64: tegra: Add stdout-path for various boards

Laxman Dewangan (1):
      arm64: tegra: Enable power and volume keys on Jetson TX1

Rhyland Klein (3):
      arm64: tegra: Add gpio-keys nodes for Smaug
      arm64: tegra: Add pinmux for Smaug board
      arm64: tegra: Enable cros-ec and charger on Smaug

Sudeep Holla (1):
      arm64: tegra: Replace legacy *,wakeup property with wakeup-source

Thierry Reding (2):
      arm64: tegra: Remove 0, prefix from unit-addresses
      arm64: tegra: Fix copy/paste typo in several DTS includes

 arch/arm64/boot/dts/nvidia/Makefile            |    1 +
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts |   55 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi       |  120 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi |    8 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi |   14 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2571.dts  |    2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2595.dtsi |    2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi |   30 +-
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts  | 1424 ++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi       |  122 +-
 10 files changed, 1617 insertions(+), 161 deletions(-)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
