From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Fri, 10 Oct 2014 18:50:04 +0300
Subject: =?UTF-8?q?=5BPATCH=200/3=5D=20pwm=3A=20support=20backward=20compatibility=20of=20DTB=20extending=20PWM=20args?=
Message-ID: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please review this alternative in-house version of supporting backward
compatibility of DTB files, if pwms arguments of exisitng PWM drivers
are to be extended with polarity field.

Unfortunately I've firstly created the change and only after that
found that Lothar Wa?mann is working on his version, so I won't insist
on formal preference, but still I like to share my variant since it
technically different from Lothar's one.

One visual benefit of my verison is that if this version is accepted,
then of_pwm_xlate_with_flags() can be removed from all touched PWM
drivers and pwm/core.c as a redundant interface and generally is looks
to be a more simple change.

The particular changes in iMX PWM driver and other PWM drivers are out
of this change scope.

Feel free to criticize the change.

Vladimir Zapolskiy (3):
  pwm: process pwm polarity argument in of_pwm_simple_xlate()
  pwm: push up dynamic printk level on errors in of_pwm_get()
  pwm: set the actual number of pwms arguments defined in board dts

 drivers/pwm/core.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
1.7.10.4
