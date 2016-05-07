From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat,  7 May 2016 13:10:28 +0200
Subject: [GIT PULL] ARM: dts: exynos: Non-critical fixes for v4.7
Message-ID: <1462619428-13798-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A bunch of fixes for things probably broken for long time (MFC, regulator
debugfs) or for stuff which will be broken in next releases (conversion
of max8997 to regmap).


Best regards,
Krzysztof


The following changes since commit a0a966b83873f33778710a4fc59240244b0734a5:

  ARM: EXYNOS: Properly skip unitialized parent clock in power domain on (2016-04-25 11:35:37 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-non-critical-4.7

for you to fetch changes up to 330d12764e15f6e3e94ff34cda29db96d2589c24:

  ARM: dts: exynos: Add interrupt line to MAX8997 PMIC on exynos4210-trats (2016-05-06 16:01:32 +0200)

----------------------------------------------------------------
Samsung DTS non-critical fixes for v4.7:
1. Fix s5p-mfc driver probe on Exynos542x Peach boards (need to provide MFC
   memory banks). On these boards this was broken for long time but
   apparently no one enabled this driver till now.
2. Fix creation of debugfs entries for one regulator on Exynos4210
   Trats board.
3. Fix probing of max8997 MFD driver (and its children) because
   of missing interrupt. Actually the current version of the driver probes
   (just without interrupts) but after switching to regmap and regmap-irq,
   the interrupt will be mandatory.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: dts: exynos: Add MFC memory banks for Peach boards

Marek Szyprowski (2):
      ARM: dts: exynos: Fix regulator name to avoid forbidden character on exynos4210-trats
      ARM: dts: exynos: Add interrupt line to MAX8997 PMIC on exynos4210-trats

 arch/arm/boot/dts/exynos4210-trats.dts     | 4 +++-
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 5 +++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)
