From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Feb 2012 19:53:46 +0900
Subject: [GIT PULL] Samsung EXYNOS pm domains for devel
Message-ID: <010a01cce7e2$438f6d40$caae47c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull samsung exynos pm domains.

It has been merged into linux-pm tree by Rafael and I think it should be
pulled into arm-soc.

Following is regarding reply about that.

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/082909.h
tml

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.4-for-rafael

Thomas Abraham (2):
      PM / Domains: Add OF support
      ARM: EXYNOS: Hook up power domains to generic power domain
infrastructure

 .../bindings/arm/exynos/power_domain.txt           |   21 ++
 arch/arm/mach-exynos/Kconfig                       |   10 +-
 arch/arm/mach-exynos/Makefile                      |    2 +-
 arch/arm/mach-exynos/dev-pd.c                      |  139 --------------
 arch/arm/mach-exynos/mach-nuri.c                   |   11 -
 arch/arm/mach-exynos/mach-origen.c                 |   14 --
 arch/arm/mach-exynos/mach-smdkv310.c               |   12 --
 arch/arm/mach-exynos/mach-universal_c210.c         |   17 --
 arch/arm/mach-exynos/pm_domains.c                  |  195
++++++++++++++++++++
 drivers/base/power/domain.c                        |   32 ++++
 include/linux/pm_domain.h                          |   12 ++
 11 files changed, 262 insertions(+), 203 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/arm/exynos/power_domain.txt
 delete mode 100644 arch/arm/mach-exynos/dev-pd.c
 create mode 100644 arch/arm/mach-exynos/pm_domains.c
