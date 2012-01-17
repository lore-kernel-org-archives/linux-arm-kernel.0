From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 18 Jan 2012 00:40:16 +0100
Subject: [PATCH 0/4] at91 : cleanup pm.h
Message-ID: <1326843620-13148-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes some cleanup and fix the rm9200 code by replacing
the standby routine by a asm routine where we have a better control.

This patchset has been tested on a sam9263, compiled on the other
platform but not tested because I don't have the hardware. 

This is my first attempt for an asm arm routine ...

Daniel Lezcano (4):
  at91 : coding style fixes
  at91 : declare header name
  at91 : remove wait_for_interrupt definition
  at91 : implement the standby function for pm/cpuidle

 arch/arm/mach-at91/cpuidle.c |   11 +----
 arch/arm/mach-at91/pm.c      |   12 +-----
 arch/arm/mach-at91/pm.h      |   86 +++++++++++++++++++++++++++---------------
 3 files changed, 59 insertions(+), 50 deletions(-)

-- 
1.7.5.4
