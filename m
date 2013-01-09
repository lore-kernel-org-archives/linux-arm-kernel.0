From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Wed, 09 Jan 2013 18:24:38 +0530
Subject: [PATCH 0/3] ARM:exynos5:power-domain: Save and restore CLK_TOP_SRC3
 via clock framework.
Message-ID: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After Suspend-Resume operation of exynos5, CLK_TOP_SRC3 register modified
while power gating G-scaler and MFC power domains.This is seen only after
suspend and resume.

The solution to this problem is to save CLK_SRC_TOP3 register and restore
it while powergating. But CLK_SRC_TOP3 register cannot accessed directly 
by power domain code.
Please refer below URL to know the background of this issue.
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14347.html.

This patch set adds clock framework support for save and restore
clock register (CLK_SRC_TOP3)  for G-scaler and MFC power domains.

This patch set depends on
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14648.html

Prasanna Kumar (3):
  ARM: dts: exynos5: Add power domain clocks to pd node of Gscaler and MFC
  ARM:exynos5:dts: Bindings for clock definitions are added.
  ARM: exynos5: Add clock save and restore operation(CLK_SRC_TOP3) using clock framework.

 .../bindings/arm/exynos/power_domain.txt           |   14 ++
 arch/arm/boot/dts/exynos5250.dtsi                  |    2 +
 arch/arm/mach-exynos/pm_domains.c                  |  125 ++++++++++++++++++++
 3 files changed, 141 insertions(+), 0 deletions(-)

-- 
1.7.5.4
