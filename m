From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 11 Apr 2014 17:26:40 +0200
Subject: [PATCH 0/4] PM / Domains: Remove some code and APIs to simplify genpd
Message-ID: <1397230004-22306-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some parts in the generic power domain seems just too generic. Simplify the code
by removing it, which also happens to include two APIs.

For the SOC specific patch for shmobile, I am seeking an ack since it needs to
go together with the rest of patches.

Ulf Hansson (4):
  ARM: shmobile: Ignore callbacks for subsys generic_pm_domain_data
  PM / Domains: Ignore callbacks for subsys generic_pm_domain_data
  PM / Domains: Remove the pm_genpd_add|remove_callbacks APIs
  PM / Domains: Remove system PM callbacks from gpd_dev_ops

 arch/arm/mach-shmobile/pm-rmobile.c |   38 +----
 drivers/base/power/domain.c         |  285 +----------------------------------
 include/linux/pm_domain.h           |   28 ----
 3 files changed, 11 insertions(+), 340 deletions(-)

-- 
1.7.9.5
