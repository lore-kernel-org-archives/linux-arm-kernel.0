From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Thu,  6 Apr 2017 10:42:26 -0700
Subject: [GIT PULL] ARM: SOC PM domain for 4.12
Message-ID: <1491500546-6873-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

As inidcated on the list, because of various dependencies, am senidng
Dave Gerlach's full patchset in single pull request. 

The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:

  Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/arm-soc-pmdomain

for you to fetch changes up to ae3874cc931b760c08bd6617a45fec1ba97d87f8:

  ARM: keystone: Drop PM domain support for k2g (2017-04-04 08:59:28 -0700)

----------------------------------------------------------------
ARM SOC PM domain support for 4.12

Dave Gerlach (5):
      PM / Domains: Add generic data pointer to genpd data struct
      PM / Domains: Do not check if simple providers have phandle cells
      dt-bindings: Add TI SCI PM Domains
      soc: ti: Add ti_sci_pm_domains driver
      ARM: keystone: Drop PM domain support for k2g

----------------------------------------------------------------
Dave Gerlach (5):
      PM / Domains: Add generic data pointer to genpd data struct
      PM / Domains: Do not check if simple providers have phandle cells
      dt-bindings: Add TI SCI PM Domains
      soc: ti: Add ti_sci_pm_domains driver
      ARM: keystone: Drop PM domain support for k2g

 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  57 ++++++
 MAINTAINERS                                        |   3 +
 arch/arm/mach-keystone/Kconfig                     |   1 +
 arch/arm/mach-keystone/pm_domain.c                 |   4 +-
 drivers/base/power/domain.c                        |   2 -
 drivers/soc/ti/Kconfig                             |  12 ++
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/ti_sci_pm_domains.c                 | 202 +++++++++++++++++++++
 include/dt-bindings/genpd/k2g.h                    |  90 +++++++++
 include/linux/pm_domain.h                          |   1 +
 10 files changed, 370 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 create mode 100644 drivers/soc/ti/ti_sci_pm_domains.c
 create mode 100644 include/dt-bindings/genpd/k2g.h
