From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 06 Oct 2015 11:23:58 +0300
Subject: [PATCH 0/2] ARM: EXYNOS: Allow to use architected timer
Message-ID: <cover.1444119342.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos platform officially uses "multi-core timer" AKA MCT. However, it
also has a possibility to access the same timer using CP15 (AKA
architected timer) registers.

In order to be able to use KVM, we need CP15 timer support. In its turn,
MCT needs to be turned on before any accesses will work. This patchset
allows to specify "CP15 compatibility mode" for the MCT by inserting
armv7-timer node as a child for MCT device. In this case MCT driver will
only enable the timer, leaving the rest for architected timer driver.

Pavel Fedin (2):
  exynos_mct: Allow to use architected timer mode
  ARM: dts: Use architected timer on Exynos 5410

 arch/arm/boot/dts/exynos5410.dtsi | 11 +++++++++++
 drivers/clocksource/exynos_mct.c  | 19 +++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.4.4
