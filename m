From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 13 Jul 2012 15:05:00 +0530
Subject: [PATCH 0/2] PWM driver support for EHRPWM & ECAP
Message-ID: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for PWM driver support for EHRPWM
and ECAP modules which has been present on AM335x SOC. AM335X SOC has 3
instances of ECAP & EHRPWM.

EHRPWM device can be used to generate PWM waveforms. It has 2 channels of PWM
output and each can be configured for different duty cycle and polarity.

ECAP device can be used as either Capture or APWM mode. In APWM mode, ECAP
can generate PWM waveform.

Patch #1 adds Generic PWM driver support for simple APWM functionality of ECAP
ECAP hardware.

Patch #2 adds  PWM driver support for EHRPWM device.

This patch series is based on new PWM framework maintained at [1].

1. https://gitorious.org/linux-pwm/linux-pwm/trees/for-next
2. http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104483.html

Philip, Avinash (2):
  PWM: ECAP: PWM driver support for ECAP APWM.
  PWM: EHRPWM: PWM driver support for EHRPWM.

 drivers/pwm/Kconfig      |   22 ++
 drivers/pwm/Makefile     |    2 +
 drivers/pwm/pwm-ecap.c   |  255 +++++++++++++++++++++++++
 drivers/pwm/pwm-ehrpwm.c |  476 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 755 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pwm/pwm-ecap.c
 create mode 100644 drivers/pwm/pwm-ehrpwm.c
