From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Mar 2014 09:53:57 +0000 (GMT)
Subject: [GIT PULL 3/6] Samsung DT updates for v3.15
Message-ID: <23081058.260441393840435413.JavaMail.weblogic@epml16>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git tags/samsung-dt

for you to fetch changes up to d726ca2d3316743841063a98fb113ff22a236e63:

  ARM: dts: Add vmmc-supply to MMC on arndale-octa board (2014-02-24 08:56:46 +0900)

----------------------------------------------------------------
Samsung DT updates for v3.15

For exynos4412
- update vdd_arm voltage range for odroidx board

For exynos5250
- add PMU sysreg node and update watchdog node
- re-organize RTC status
- add max77686 pmic node for smdk5250

For exynos5420
- add PMU sysreg, i2s, adma and watchdog nodes
- re-organize RTC status
- add fixed voltage regulators and regulator nodes
  for smdk5420
- add PMIC, GPIO based wake up key and vmmc-supply
  support for arndale-octa board

----------------------------------------------------------------
Leela Krishna Amudala (2):
      ARM: dts: Add pmu sysreg node to exynos5250 and exynos5420
      ARM: dts: update watchdog device nodes for exynos5250 and exynos5420

Sachin Kamat (9):
      ARM: dts: Add regulator entries to smdk5420
      ARM: dts: Re-organize RTC status for exynos5420
      ARM: dts: Re-organize RTC status for exynos5250
      ARM: dts: Add ADMA node to exynos5420
      ARM: dts: Add I2S nodes to exynos5420
      ARM: dts: Add fixed voltage regulators to smdk5420
      ARM: dts: Add PMIC support to arndale-octa board
      ARM: dts: Add wake up key to arndale-octa board
      ARM: dts: Add vmmc-supply to MMC on arndale-octa board

Thomas Abraham (2):
      ARM: dts: update vdd_arm voltage range for exynos4412 based boards
      ARM: dts: add max77686 pmic node for smdk5250

 .../devicetree/bindings/arm/samsung/pmu.txt        |   15 +
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |    4 +-
 arch/arm/boot/dts/exynos5.dtsi                     |    7 -
 arch/arm/boot/dts/exynos5250-arndale.dts           |    4 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  146 ++++++++++
 arch/arm/boot/dts/exynos5250-snow.dts              |    4 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   13 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  298 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  253 +++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                  |   70 ++++-
 11 files changed, 803 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
