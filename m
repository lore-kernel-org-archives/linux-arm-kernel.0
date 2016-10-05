From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed,  5 Oct 2016 14:31:51 -0600
Subject: [PATCH 0/8] PM / Domains: DT support for domain idle states & atomic
 PM domains
Message-ID: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the first set of patches of [1], sent now seperately. The CPU PM
domains part of the series is under discussion and was gating this set of
patches which have already been looked at by many and has no objections. Hence,
I split the series and sending out the PM domains changes now.

The patches [1 - 3] add DT support for reading domain idle states. The second
set of patches [4 - 8] enable PM domains to be used in atomic context.

The changes from [1] are -
- Allocating memory for domain idle states dynamically
- Conform to naming conventions for internal and exported genpd functions
- DT binding example for domain-idle-state
- Use fwnode instead of of_node
- Handle atomic case for removal of PM Domain
- Rebase on top of Rafael's pm/genpd tree

Thanks,
Lina

Lina Iyer (8):
  PM / Domains: Make genpd state allocation dynamic
  PM / Domain: Add residency property to genpd states
  PM / Domains: Allow domain power states to be read from DT
  PM / Domains: Add fwnode provider to genpd states
  dt/bindings: Update binding for PM domain idle states
  PM / Domains: Abstract genpd locking
  PM / Domains: Support IRQ safe PM domains
  PM / doc: Update device documentation for devices in IRQ safe PM
    domains

 .../devicetree/bindings/power/power_domain.txt     |  36 +++
 Documentation/power/devices.txt                    |  12 +-
 arch/arm/mach-imx/gpc.c                            |  17 +-
 drivers/base/power/domain.c                        | 338 +++++++++++++++++----
 include/linux/pm_domain.h                          |  27 +-
 5 files changed, 360 insertions(+), 70 deletions(-)

-- 
2.7.4

[1]. https://www.spinics.net/lists/arm-kernel/msg526814.html
