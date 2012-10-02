From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 02 Oct 2012 11:24:02 +0200
Subject: [PATCH v2 0/4] ARM: EXYNOS: Power domain DT support extension
Message-ID: <1349169846-30385-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes two issues with existing DT support for Exynos
power domains and extends it with the ability of binding devices to domains,
basically making it possible to use power domains with DT.

Based on next/dt-samsung-new branch of Samsung tree.

Changes since v1:
 - Added "samsung," prefix to "power-domain" property.
 - Added power domain nodes to Exynos4 device tree sources.

Tomasz Figa (4):
  ARM: EXYNOS: pm_domain: Detect domain state on registration from DT
  ARM: EXYNOS: pm_domain: Fix power domain name initialization
  ARM: EXYNOS: pm_domain: Bind devices to power domains using DT
  ARM: dts: exynos4: Set up power domains

 .../bindings/arm/exynos/power_domain.txt           | 15 +++-
 arch/arm/boot/dts/exynos4.dtsi                     | 30 +++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  5 ++
 arch/arm/mach-exynos/pm_domains.c                  | 93 +++++++++++++++++++++-
 4 files changed, 135 insertions(+), 8 deletions(-)

-- 
1.7.12
