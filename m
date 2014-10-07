From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  7 Oct 2014 12:14:18 +0200
Subject: [PATCH v9 0/2] pwm: add support for atmel-hlcdc-pwm device
Message-ID: <1412676860-12120-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

This patch series adds support for the atmel-hlcdc-pwm device provided
by the atmel-hlcdc MFD driver.

It depends on this series [1] implementing the MFD driver.

Best Regards,

Boris

[1]http://www.mail-archive.com/devicetree at vger.kernel.org/msg44979.html

Changes since v8:
 - rework the enable/disable waiting loop
 - check return code of regmap functions
 - fix DT binding doc

Changes since v7:
 - addressed several coding style issues


Boris Brezillon (2):
  pwm: add support for atmel-hlcdc-pwm device
  pwm: add DT bindings documentation for atmel-hlcdc-pwm driver

 .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    |  29 +++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-atmel-hlcdc.c                      | 259 +++++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
 create mode 100644 drivers/pwm/pwm-atmel-hlcdc.c

-- 
1.9.1
