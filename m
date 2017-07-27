From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 27 Jul 2017 16:23:35 +0800
Subject: [PATCH v2 0/2] Add ZTE ZX PWM device driver support
Message-ID: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The series adds the dt-bindings document and device driver for PWM
controller found on ZTE ZX family SoCs.

Changes for v2:
 - Add Rob's ACK for dt-bindings patch
 - Use inline function rather than macro for to_zx_pwm_chip()
 - Convert zx_pwm_ops to implement atomic callbacks .apply() and .get_state()

Shawn Guo (2):
  dt-bindings: pwm: add bindings doc for ZTE ZX PWM controller
  pwm: add ZTE ZX PWM device driver

 Documentation/devicetree/bindings/pwm/pwm-zx.txt |  22 ++
 drivers/pwm/Kconfig                              |   9 +
 drivers/pwm/Makefile                             |   1 +
 drivers/pwm/pwm-zx.c                             | 270 +++++++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt
 create mode 100644 drivers/pwm/pwm-zx.c

-- 
1.9.1
