From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue,  1 Mar 2016 18:37:20 +0900
Subject: [GIT PULL] ARM: EXYNOS: dts for 4.6, 2nd pull
Message-ID: <1456825042-23733-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Second pull request with DT changes for v4.6.
This is on top of previous DT changes.

Best regards,
Krzysztof


The following changes since commit 36a0282a41493400428d7df8c99701fb4ee344c2:

  ARM: dts: Replace legacy *,wakeup property with wakeup-source for exynos boards (2016-01-29 09:09:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.6-2

for you to fetch changes up to 52e8e5927050055f2b26ce5f0eaa6f66377145f3:

  ARM: dts: exynos: Don't overheat the Odroid XU3-Lite on high load (2016-03-01 18:04:00 +0900)

----------------------------------------------------------------
Samsung DeviceTree updates and improvements for v4.6, second round:
1. Split common reboot/poweroff node to separate DTSI.
2. Don't overheat Odroid XU3 by cooling CPU with cpufreq.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: dts: exynos: Move syscon reboot/poweroff to common dtsi

Krzysztof Kozlowski (3):
      ARM: dts: exynos: Add cooling levels for Exynos5420 CPUs
      ARM: dts: exynos: Add cooling levels for Exynos5422/5800 CPUs
      ARM: dts: exynos: Don't overheat the Odroid XU3-Lite on high load

 arch/arm/boot/dts/exynos-syscon-restart.dtsi  | 27 ++++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi             | 15 +--------
 arch/arm/boot/dts/exynos4.dtsi                | 15 +--------
 arch/arm/boot/dts/exynos5.dtsi                | 15 +--------
 arch/arm/boot/dts/exynos5410.dtsi             | 15 +--------
 arch/arm/boot/dts/exynos5420-cpus.dtsi        | 24 ++++++++++++++
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi | 46 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/exynos5422-cpus.dtsi        | 24 ++++++++++++++
 8 files changed, 124 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos-syscon-restart.dtsi
