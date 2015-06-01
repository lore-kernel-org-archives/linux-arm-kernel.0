From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 01 Jun 2015 12:10:44 +0200
Subject: [PATCH 0/6] Exynos SYSMMU (IOMMU) dts and arch updates
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Main changes for Exynos SYSMMU (IOMMU) driver has been finally scheduled
for merging - see
https://git.kernel.org/cgit/linux/kernel/git/joro/iommu.git/commit/?h=next
In meantime there have been quite a lot of changes related to Exynos DTS
files queued for merging and my patches don't apply anymore. To ease
merge process I've decided to rebased all Exynos SYSMMU dts changes onto
latest exynos next tree from: https://github.com/krzk/linux dt-for-next

While rebasing I've fixes a few spotted issues: some nodes still used
old 'samsung,power-domain' properties (now replaced with 'power-domains')
and added properties to jpeg codec merged recently.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland



Marek Szyprowski (6):
  ARM: Exynos: pm_domains: register power domain driver from
    core_initcall
  ARM: dts: exynos4: add sysmmu nodes
  ARM: dts: exynos3250: add sysmmu nodes
  ARM: dts: exynos4415: add sysmmu nodes
  ARM: dts: exynos5250: add sysmmu nodes
  ARM: dts: exynos5420: add sysmmu nodes

 arch/arm/boot/dts/exynos3250.dtsi |  33 +++++
 arch/arm/boot/dts/exynos4.dtsi    | 118 ++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |  23 ++++
 arch/arm/boot/dts/exynos4415.dtsi |  11 ++
 arch/arm/boot/dts/exynos4x12.dtsi |  82 +++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi | 250 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi | 183 ++++++++++++++++++++++++++++
 arch/arm/mach-exynos/pm_domains.c |  25 ++--
 8 files changed, 707 insertions(+), 18 deletions(-)

-- 
1.9.2
