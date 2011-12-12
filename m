From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 12 Dec 2011 21:16:27 +0530
Subject: [PATCH 0/2] ARM: Exynos: Adapt to generic power domain
Message-ID: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power domains available on Exynos4 are made controllable using the generic
power domain infrastructure. The existing power domain code is not removed by
this patchset. Support for both DT and non-DT Exynos platforms is added.

The first patch adds device tree support for generic power domain. A device
node is added to the generic power domain strucure that represents a power
domain node in the device tree. Other device nodes in the device tree can
include a property with a phandle of the power domain node which will enable
that device to be associated with a power domain.

The second patch registers available power domains to generic power domain
framework with support for both dt and non-dt platforms.

The patchset is based on the following tree
http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next

with all patches merged from
http://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

Thomas Abraham (2):
  PM / Domains: Add OF support
  ARM: Exynos: Hook up power domains to generic power domain infrastructure

 arch/arm/mach-exynos/Kconfig |    1 +
 arch/arm/mach-exynos/pm.c    |  179 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/domain.c  |   14 +++-
 include/linux/pm_domain.h    |   13 +++-
 4 files changed, 204 insertions(+), 3 deletions(-)
