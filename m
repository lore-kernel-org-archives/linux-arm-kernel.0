From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 29 Jan 2015 09:34:27 +0900
Subject: [GIT PULL 4/4] Samsung 3rd DT updates for v3.20
Message-ID: <54C98013.1080200@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is another Samsung DT updates for v3.20. Since including a clock
patch with Mike and Sylwester's acks so sending separate pull-request.

Please pull and if any problems please let me know.

Thanks,
Kukjin


The following changes since commit 6591a02e17e6d6587c3cf7588d523fa6f26b584a:

  ARM: dts: reduce total RAM by 22 MiB for exynos5422-odroidxu3
(2015-01-24 13:24:10 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-3

for you to fetch changes up to ea08de16eb1ba2052ce2db4b58b62a2ec33357a3:

  ARM: dts: Add DISP1 power domain for exynos5420 (2015-01-29 08:52:23
+0900)

----------------------------------------------------------------
Samsung 3rd DT updates for v3.20

- add DISP1 power domain for support HDMI support on exynos5420/5422/5800
  and the power domain node including FIMD1, MIXER and HDMI modules
  (tested on exynos5420 Peach Pit and exynos5800 Peach Pi Chromebooks
  and exynos5422 Odroid XU3 by Javier Martinez Canillas)

Note this is including a patch for adding clock IDs for the DISP1 power
domain with Mike and Sylwester's acks so that could be handled together
to avoid non-working.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      clk: exynos5420: Add IDs for clocks used in DISP1 power domain
      ARM: dts: Add DISP1 power domain for exynos5420

 arch/arm/boot/dts/exynos5420.dtsi      | 17 +++++++++++++++++
 drivers/clk/samsung/clk-exynos5420.c   | 23 ++++++++++++-----------
 include/dt-bindings/clock/exynos5420.h |  6 ++++++
 3 files changed, 35 insertions(+), 11 deletions(-)
