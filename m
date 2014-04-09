From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Apr 2014 20:04:07 +0200
Subject: [PATCH 0/2] improve pwm lookup support without device tree
Message-ID: <1397066649-3767-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

a small patch set as suggested byt Thierry to make lokkup with the lookup table
instead of device tree bahve more like when using device tree.

The first patch adds a period annd a polarity member to the lookup table and use
those to set period and polarity.

The second patch changes PWM_LOOKUP to set period an polarity. I was wondering
about adding a new macro to d that but the number of boards using it is limited
(only 3) so I guess it is ok to do that now.

The final goal would be to get rid of .pwm_period_ns in leds-pwm and pwm_bl.

Alexandre Belloni (2):
  pwm: add period and polarity to struct pwm_lookup
  pwm: use PWM_LOOKUP to set the period and polarity

 Documentation/pwm.txt                          | 3 ++-
 arch/arm/mach-omap2/board-omap3beagle.c        | 3 ++-
 arch/arm/mach-pxa/hx4700.c                     | 3 ++-
 arch/arm/mach-shmobile/board-armadillo800eva.c | 3 ++-
 drivers/pwm/core.c                             | 5 +++++
 include/linux/pwm.h                            | 6 +++++-
 6 files changed, 18 insertions(+), 5 deletions(-)

-- 
1.8.3.2
