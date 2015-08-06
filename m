From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Wed,  5 Aug 2015 23:31:45 -0300
Subject: [PATCH v2 0/2] Add support for NXP LPC18xx PWM/SCT
Message-ID: <1438828307-14641-1-git-send-email-ariel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for NXP LPC18xx PWM/SCT.

NXP LPC SoCs family, which includes LPC18xx/LPC43xx, provides a State
Configurable Timer (SCT) which can be configured as a Pulse Width Modulator.
Other SoCs in that family may share the same hardware.

Patchset is based on tag next-20150723 of the linux-next repository.
It has been successfully tested on a Hitex LPC4350 Evaluation Board.

Changes since v1:
* Added "sct" in DT compatible string and driver's name.
* Allowed period changes when there's only one channel requested.

Ariel D'Alessandro (2):
  pwm: NXP LPC18xx PWM/SCT driver
  DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation

 .../devicetree/bindings/pwm/lpc1850-sct-pwm.txt    |  20 +
 drivers/pwm/Kconfig                                |  12 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-lpc18xx-sct.c                      | 465 +++++++++++++++++++++
 4 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
 create mode 100644 drivers/pwm/pwm-lpc18xx-sct.c

-- 
1.9.1
