From: elder@linaro.org (Alex Elder)
Date: Tue,  8 Apr 2014 17:23:51 -0500
Subject: [PATCH v2 0/5] clk: bcm21664: add common clock support
Message-ID: <1396995836-31111-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is series has two parts.  The first two patches are changes
to the existing Broadcom Kona family clock code to prepare for the
addition of support for another SoC, bcm21664.

The remaining three define the binding and code for bcm21664, and
replace the use of "fake" clocks in the device tree with the real
ones.  This ends up being a fairly straightforward definition of
the clocks on this SoC; the rest of the clock code is shared with
other SoCs that use the Kona style clock system.

This series depends on the following patch, which has been taken
into the clk-fixes tree:
    clk: bcm281xx: don't use unnamed structs or unions
    https://lkml.org/lkml/2014/4/7/322

In addition, it depends on the version 4 of the following series,
just (re)posted for review:
    clk: bcm281xx: updates
    https://lkml.org/lkml/2014/4/8/485

The patches in this series--based on the current linus/master branch
plus the patches mentioned above--are available here:
    http://git.linaro.org/git/landing-teams/working/broadcom/kernel.git
    Branch review/bcm21664-clock-v2


					-Alex

Alex Elder (5):
  clk: bcm281xx: move compatible string definitions
  ARM: dts: revise kona clock binding document
  ARM: dts: define clock binding for bcm21664
  clk: bcm21664: use common clock framework
  ARM: dts: use real clocks for bcm21664

 .../devicetree/bindings/clock/bcm-kona-clock.txt   |  116 +++++---
 arch/arm/boot/dts/bcm21664.dtsi                    |  190 ++++++++-----
 drivers/clk/bcm/Kconfig                            |    2 +-
 drivers/clk/bcm/Makefile                           |    1 +
 drivers/clk/bcm/clk-bcm21664.c                     |  290 ++++++++++++++++++++
 drivers/clk/bcm/clk-bcm281xx.c                     |   12 -
 include/dt-bindings/clock/bcm21664.h               |   62 +++++
 include/dt-bindings/clock/bcm281xx.h               |   12 +
 8 files changed, 565 insertions(+), 120 deletions(-)
 create mode 100644 drivers/clk/bcm/clk-bcm21664.c
 create mode 100644 include/dt-bindings/clock/bcm21664.h

-- 
1.7.9.5
