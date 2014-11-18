From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Tue, 18 Nov 2014 21:37:18 +0200
Subject: [PATCH v3 0/5] pwm: support backward compatibility of DTB extending
 PWM args
Message-ID: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please review this alternative in-house version of supporting backward
compatibility of DTB files (new kernel/PWM driver and old DTS), overcoming
a problem that pwms arguments of existing PWM drivers are to be extended
with polarity field.

Unfortunately I've firstly created the change and only after that
found that Lothar Wa?mann is working on his version, so I won't insist
on formal preference, but still I like to share my variant since it
technically different from Lothar's one.

Changes from v2 to v3:
- improved commit messages
- added two more patches removing of_pwm_xlate_with_flags()

Changes from v1 to v2:
- corrected the proper kernel log level, thanks to Lothar Wa?mann.

Vladimir Zapolskiy (5):
  pwm: process pwm polarity argument in of_pwm_simple_xlate()
  pwm: push up dynamic printk level on errors in of_pwm_get()
  pwm: set the actual number of pwms arguments defined in board dts
  pwm: do not set of_pwm_xlate_with_flags() as a callback
  pwm: remove of_pwm_xlate_with_flags() function

 drivers/pwm/core.c            |   42 ++++++++++++-----------------------------
 drivers/pwm/pwm-atmel-hlcdc.c |    2 --
 drivers/pwm/pwm-atmel-tcb.c   |    2 --
 drivers/pwm/pwm-atmel.c       |    6 ------
 drivers/pwm/pwm-bcm-kona.c    |    2 --
 drivers/pwm/pwm-fsl-ftm.c     |    2 --
 drivers/pwm/pwm-renesas-tpu.c |    2 --
 drivers/pwm/pwm-rockchip.c    |    5 -----
 drivers/pwm/pwm-samsung.c     |    3 ---
 drivers/pwm/pwm-tiecap.c      |    2 --
 drivers/pwm/pwm-tiehrpwm.c    |    2 --
 drivers/pwm/pwm-vt8500.c      |    2 --
 include/linux/pwm.h           |    3 ---
 13 files changed, 12 insertions(+), 63 deletions(-)

-- 
1.7.10.4
