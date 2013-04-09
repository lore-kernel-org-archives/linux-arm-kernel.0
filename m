From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Apr 2013 20:24:37 +0800
Subject: [GIT PULL v2] imx fixes for 3.9, take 5
Message-ID: <20130409122435.GK5047@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 * Drop patch "cpuimx27 and mbimx27: prepend CONFIG_ to Kconfig macro"
   which is queued for 3.10 now.
 * Add patches "ARM i.MX6: Fix ldb_di clock selection" and "ARM: imx:
   provide twd clock lookup from device tree"

The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:

  Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.9-5

for you to fetch changes up to e8094b2c17126c7dfdeafa296f206a4a3b122d23:

  ARM i.MX6: Fix ldb_di clock selection (2013-04-09 19:48:09 +0800)

----------------------------------------------------------------
The imx fixes for 3.9, take 5:

* A couple imx35 clock fixes for regressions caused by common clock
  framework conversion.  The admux and iomux get disabled by common
  clock framework late initcall, and hence causes problems.
* Add missing twd clock lookup in device tree.  This becomes required
  since commit bd60345 (ARM: use device tree to get smp_twd clock)
  forces all DT boot to find lookup from device tree.
* Fix imx6q ldb_di clock parents mismatch per reference manual.

----------------------------------------------------------------
Dirk Behme (1):
      ARM i.MX6: Fix ldb_di clock selection

Markus Pargmann (2):
      ARM: clk-imx35: Bugfix iomux clock
      ARM: imx35 Bugfix admux clock

Shawn Guo (1):
      ARM: imx: provide twd clock lookup from device tree

 arch/arm/boot/dts/imx6qdl.dtsi |    1 +
 arch/arm/mach-imx/clk-imx35.c  |    2 ++
 arch/arm/mach-imx/clk-imx6q.c  |    3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)
