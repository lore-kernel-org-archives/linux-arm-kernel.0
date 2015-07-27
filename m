From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Mon, 27 Jul 2015 01:45:43 -0300
Subject: [PATCH 0/2] Add support for NXP LPC18xx PWM/SCT
Message-ID: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for NXP LPC18xx PWM/SCT.

NXP LPC SoCs family, which includes LPC18xx/LPC43xx, provides a State
Configurable Timer (SCT) which can be configured as a Pulse Width Modulator.
Other SoCs in that family may share the same hardware.

Patchset is based on tag next-20150723 of the linux-next repository.
It has been successfully tested on a Hitex LPC4350 Evaluation Board.

Ariel D'Alessandro (2):
  pwm: NXP LPC18xx PWM/SCT driver
  DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation

 .../devicetree/bindings/pwm/lpc1850-pwm.txt        |  20 +
 drivers/pwm/Kconfig                                |  12 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-lpc18xx.c                          | 453 +++++++++++++++++++++
 4 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
 create mode 100644 drivers/pwm/pwm-lpc18xx.c

-- 
1.9.1
