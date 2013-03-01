From: hechtb@gmail.com (Bastian Hecht)
Date: Fri,  1 Mar 2013 11:45:29 -0600
Subject: [PATCH 0/3] Add OF support to CMT driver - bindings discussion
Message-ID: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

here in the CMT driver we currently can derive all neccessary hardware info from the device ID and channel ID (there are multiple CMT instances built into one SoC with multiple channels each). This seems like a very intuituve description to me.

If multiple register layouts appear we can add an (optional) regtype property and some parts of the driver need to be rewritten anyway. But the descriptiveness of device ID and channel ID should stay I think.

Will this work?

In the patchset I have added the dts specification to sh73a0-kzm9g-reference.dts to test it. Does this belong to sh73a0.dtsi instead? I wonder because the clock is in the setup code, not board code.

Thanks,

 Bastian


Bastian Hecht (3):
  clocksource: sh_cmt: Add Device Tree probing
  ARM: mach-shmobile: sh73a0: Add CMT DT name to clock list
  ARM: mach-shmobile: sh73a0: Setup the timer device CMT10 using DT

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   11 ++++
 arch/arm/mach-shmobile/clock-sh73a0.c        |    1 +
 arch/arm/mach-shmobile/setup-sh73a0.c        |    1 -
 drivers/clocksource/sh_cmt.c                 |   87 ++++++++++++++++++++++----
 4 files changed, 86 insertions(+), 14 deletions(-)

-- 
1.7.9.5
