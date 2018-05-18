From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 18 May 2018 17:24:02 +0200
Subject: [PATCH 0/2] Fix STM32 PWM capture build with COMPILE_TEST
Message-ID: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build issue has been identified when COMPILE_TEST=y and MFD_STM32_TIMERS=n:
https://lkml.org/lkml/2018/5/17/825
- First patch introduces a stub routine in mfd header file
- Sub-sequent patch solves warning in pwm-stm32 with these configs

Fabrice Gasnier (2):
  mfd: stm32-timers: fix pwm-stm32 linker issue with COMPILE_TEST
  pwm: stm32: initialize raw local variables

 drivers/pwm/pwm-stm32.c          |  2 +-
 include/linux/mfd/stm32-timers.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
1.9.1
