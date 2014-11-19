From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 19 Nov 2014 15:00:35 +0100
Subject: [PATCH 0/3] PM / Domains: Add initial PM clock support to genpd
Message-ID: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's quite common for PM domains to use PM clocks. Typically from SOC specific
code, the per device PM clock list is created and pm_clk_suspend|resume() are
invoked to handle clock gating/ungating.

A step towards consolidation is to integrate PM clock support into genpd, which
is what this patchset does.

In this initial step, the calls to the pm_clk_suspend|resume() are handled
within genpd, but the per device PM clock list still needs to be created from
SOC specific code. It seems reasonable to have gendp to handle that as well, but
that left to future patchsets to address.

It's not every users of genpd that are keen on using PM clocks thus we need
to provide this a configuration option for genpd.

In patch 2 and patch 3, we convert some of the SH-MOBILE SOCs to start using the
new PM clock support in genpd.


Ulf Hansson (3):
  PM / Domains: Initial PM clock support for genpd
  ARM: shmobile: Convert to genpd flags for PM clocks for r8a7779
  ARM: shmobile: Convert to genpd flags for PM clocks for R-mobile

 arch/arm/mach-shmobile/pm-r8a7779.c | 3 +--
 arch/arm/mach-shmobile/pm-rmobile.c | 3 +--
 drivers/base/power/domain.c         | 7 +++++++
 include/linux/pm_domain.h           | 3 +++
 4 files changed, 12 insertions(+), 4 deletions(-)

-- 
1.9.1
