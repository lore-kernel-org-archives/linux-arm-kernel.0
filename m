From: lis8215@gmail.com (lis8215 at gmail.com)
Date: Tue,  7 Feb 2017 20:50:42 +0300
Subject: [PATCH v2 0/4] Add the Allwinner A31/A31s PWM driver
Message-ID: <1486489846-662-1-git-send-email-lis8215@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Siarhei Volkau <lis8215@gmail.com>

First of all im sorry for accidentally sent old patch,
please ignore them.

This is the second version of the sun6i PWM patchset.
 - added missing documentation changes
 - dts changes in separate patch

Thanks to Julian Calaby for tips.

--------------------------
This series of patches introduces support for Allwinner A31 PWM, which
is significantly differ from PWM founded in other Allwinner SoCs.
Patches 1/4 and 2/4 refactors existing code for easier A31 PWM integration.
Patch 3/4 adds support for A31 PWM on top of existing Allwinner PWM driver.
Patch 4/4 adds the PWM block to A31/A31s device tree.

Siarhei Volkau (4):
  ARM: pwm: sun4i: unification of register operations for support sun6i.
  ARM: pwm: sun4i: selectable prescaler table for support sun6i.
  ARM: pwm: sun6i: add support the Allwinner A31 PWM.
  ARM: dts: sun6i: Add the PWM block to the A31/A31s.

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |   3 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   8 +
 drivers/pwm/pwm-sun4i.c                            | 193 ++++++++++++++++++---
 3 files changed, 176 insertions(+), 28 deletions(-)

-- 
2.4.11
