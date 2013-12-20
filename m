From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Dec 2013 22:41:06 +0100
Subject: [PATCH 0/3] ARM: sunxi: Add A31 High Speed Timer Support
Message-ID: <1387575669-21253-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset enables support for the High Speed Timer IP found in the
Allwinner A31 SoCs.

These timers are asserted in reset, and are not associated with any struct
device, so we also add a small helper to the reset framework along the way to
be able to retrieve the reset controller from the device tree directly.

Thanks,
Maxime

Maxime Ripard (3):
  reset: Add of_reset_control_get
  clocksource: sun5i: Add support for reset controller
  ARM: sun6i: a31: Add support for the High Speed Timers

 .../bindings/timer/allwinner,sun5i-a13-hstimer.txt |  4 +++
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 11 ++++++
 drivers/clocksource/timer-sun5i.c                  |  6 ++++
 drivers/reset/core.c                               | 39 +++++++++++++++++-----
 include/linux/reset.h                              |  4 +++
 5 files changed, 55 insertions(+), 9 deletions(-)

-- 
1.8.4.2
