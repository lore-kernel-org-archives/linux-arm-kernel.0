From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 24 Oct 2016 15:20:59 -0700
Subject: [PATCH v4 0/9] PM / Domains: DT support for domain idle states &
 atomic PM domains
Message-ID: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Changes since v3 [5] -
- Added "domain-idle-state" compatible to arm/idle-states.txt
- Updated documentation for defining PM domain idle states
- Updated documentation for devices and PM domains.
- Updated code to look for "domain-idle-state" instead of "arm,idle-state" compatible.
- The series is available at [6].

Changes since v2 [3] -
- Addressed review comments from v2.
        - domain-idle-states documentation updated
        - fixed compiler issues with imx driver
        - minor code change in pm_domains.c
- The series is available at [4].

Changes since v1 [2] -
- Addressed review comments from v1.
        - Fixes around dynamic allocation of genpd states
        - Used OF method for iterating phandles
        - Updated documentation, examples
        - Rename state variable (provider -> fwnode)
- The series is available at [3].

The changes from [1] are -
- Allocating memory for domain idle states dynamically
- Conform to naming conventions for internal and exported genpd functions
- DT binding example for domain-idle-state
- Use fwnode instead of of_node
- Handle atomic case for removal of PM Domain
- Rebase on top of Rafael's pm/genpd tree

Thanks,
Lina

Lina Iyer (9):
  PM / Domains: Make genpd state allocation dynamic
  PM / Domain: Add residency property to genpd states
  PM / Domains: Allow domain power states to be read from DT
  dt-bindings: add domain-idle-state compatible to arm,idle-state
  dt-bindings: Update binding for PM domain idle states
  PM / Domains: Save the fwnode in genpd_power_state
  PM / Domains: Abstract genpd locking
  PM / Domains: Support IRQ safe PM domains
  PM / doc: Update device documentation for devices in IRQ safe PM
    domains

 .../devicetree/bindings/arm/idle-states.txt        |   3 +
 .../devicetree/bindings/power/power_domain.txt     |  44 +++
 Documentation/power/devices.txt                    |  14 +-
 arch/arm/mach-imx/gpc.c                            |  17 +-
 drivers/base/power/domain.c                        | 358 +++++++++++++++++----
 include/linux/pm_domain.h                          |  28 +-
 6 files changed, 392 insertions(+), 72 deletions(-)

-- 
2.7.4

[1]. https://www.spinics.net/lists/arm-kernel/msg526814.html
[2]. http://www.spinics.net/lists/arm-kernel/msg535106.html
[3]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-v2
[4]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-v3
[5]. http://www.spinics.net/lists/arm-kernel/msg536181.html
[6]. http://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-v4
