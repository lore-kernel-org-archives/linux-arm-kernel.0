From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 3 Apr 2017 21:47:27 -0500
Subject: [PATCH v5 0/5] ARM: K2G: Add support for TI-SCI Generic PM Domains
Message-ID: <20170404024732.32699-1-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This is v5 of the series to add support for TI-SCI Generic PM Domains with
all ACKs in place and ready for Santosh to merge.

Previous versions can be found here:

v4: https://www.spinics.net/lists/arm-kernel/msg566778.html
v3: https://www.spinics.net/lists/kernel/msg2413975.html
v2: https://www.spinics.net/lists/kernel/msg2364612.html
v1: http://www.spinics.net/lists/arm-kernel/msg525204.html

Mostly just a resend of v4 with all ACKs and Reviewed-by tags in place with
the exception of a dropped sentence in patch 3 to avoid referencing Linux
specific behavior in the DT binding doc. Otherwise everything else is
unmodified.

Ulf and Santosh, I kept your Reviewed-by and Acked-by tags in Patch 3 because
the change was so minor and I still wanted to give you credit for taking the
time to review the patch, any issues and I'd be happy to change that.

Regards,
Dave

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

-- 
2.11.0
