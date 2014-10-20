From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 20 Oct 2014 15:56:01 +0300
Subject: [PATCH v2 0/3] ARM: keystone: pm: switch to use generic pm domains
Message-ID: <1413809764-21995-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh, Kevin,

This series switches Keystone 2 PM code to use Generic PM domains
instead of PM clock domains because of the lack of DT support
for the last.
It will finally allow to enable Runtime PM for Keystone 2.

Patch 1 was reused from [1].

RFC version of patches can be found at [2].

Changes in v2:
- minor comments applied and rebased on top of Linux 3.18-rc1.

Link on v1:
  https://lkml.org/lkml/2014/9/29/382

[1] "[PATCH/RFC 0/4] of: Register clocks for Runtime PM with PM core"
  https://lkml.org/lkml/2014/4/24/1118

[2] "[RFC PATCH 0/4] ARM: keystone: pm: switch to use generic pm domains"
  https://lkml.org/lkml/2014/9/25/364

Geert Uytterhoeven (1):
  PM / clock_ops: Add pm_clk_add_clk()

Grygorii Strashko (2):
  ARM: keystone: pm: switch to use generic pm domains
  ARM: dts: keystone: add generic pm controller node

 .../bindings/power/ti,keystone-powerdomain.txt     |  31 ++++++
 arch/arm/boot/dts/keystone.dtsi                    |   6 ++
 arch/arm/mach-keystone/Kconfig                     |   1 +
 arch/arm/mach-keystone/pm_domain.c                 | 112 ++++++++++++++-------
 drivers/base/power/clock_ops.c                     |  41 ++++++--
 include/linux/pm_clock.h                           |   8 ++
 6 files changed, 152 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/ti,keystone-powerdomain.txt

-- 
1.9.1
