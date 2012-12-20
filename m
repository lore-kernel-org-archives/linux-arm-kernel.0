From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Thu, 20 Dec 2012 17:56:15 +0530
Subject: [PATCH v2 0/3] ARM: Exynos5 : Add Power domain device tree support and
 fix for hardware issue
In-Reply-To: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
References: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
Message-ID: <1356006378-17441-1-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
This patch set is for "for-next" branch.

Changes since v1:
[exynos5250.dtsi]
Added power domain support for MAU and ISP power domains in exynos5 dts
[pm_domains.c]
CLKSRC register is saved before PMU register is programmed
Replaced soc_is_exynos5250 with  of_machine_is_compatible 

Prasanna Kumar (3):
  ARM: dts: exynos5: Set up power domain for MFC,G-scaler,MAU and ISP
  arm: exynos5: Enable PM generic domain support in Kconfig
  ARM: EXYNOS5: save CLK_TOP_SRC3 register before powergating

 arch/arm/boot/dts/exynos5250.dtsi |   25 +++++++++++++++++++++++++
 arch/arm/mach-exynos/Kconfig      |    1 +
 arch/arm/mach-exynos/pm_domains.c |   27 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 0 deletions(-)
