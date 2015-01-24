From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 24 Jan 2015 22:33:46 +0800
Subject: [PATCH 0/2] Input: sun4i-ts: Support touchpanel controller on A31
Message-ID: <1422110028-30270-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

As part of my work to get cpufreq working, this series adds support for the
resistive touch panel controller on A31. It is the same hardware as on older
SoCs, with a few register bits shifted, and a different temperature curve.
I've matched the rest of the registers, and they all seem to fit.

As I do not have a resistive touch screen, I am asking anyone with an A31
board and a touch screen to help test this.

The temperature curve formula was confirmed by Allwinner as correct and
working.

I've yet to fully test the remaining cpufreq bits, so I'm sending out this
first. At least people will have a usable temperature sensor.


Regards,
ChenYu


Chen-Yu Tsai (2):
  Input: sun4i-ts: Add support for touchpanel controller on A31
  ARM: dts: sun6i: Add resistive touchscreen controller node to dtsi

 .../bindings/input/touchscreen/sun4i.txt           |  2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  7 ++++
 drivers/input/touchscreen/sun4i-ts.c               | 46 ++++++++++++++++------
 3 files changed, 41 insertions(+), 14 deletions(-)

-- 
2.1.4
