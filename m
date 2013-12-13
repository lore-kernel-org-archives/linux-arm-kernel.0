From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 13 Dec 2013 14:41:48 +0800
Subject: [PATCH v9 0/2] PWM: pwm-atmel: add PWM controller driver
Message-ID: <1386916910-24832-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add Atmel PWM controller driver support.

Changes in v9:
  - Address the comments from Thierry Reding

Changes in v8:
  - replace pr_err by dev_err

Changes in v7:
  - fix issue for none device tree issues.

Changes in v6:
  - using relaxed version for writel and readl
  - add none device tree support
  - change some define from lower case to upper case
  - split device tree binding document as a separate patch

Changes in v5:
  - call clk_disable directly, if so, it won't cause more than one channel
    enabled, the clock can not be disabled.

Changes in v4:
  - check the return value of clk_prepare()
  - change channel register size as constant

Changes in v3:
  - change compatible string from "atmel,sama5-pwm" to "atmel,sama5d3-pwm"
  - Add PWM led example in binding documentation
  - Using micro replace hard code

Changes in v2:
  - Address the comments from Thierry Reding


Bo Shen (2):
  PWM: atmel-pwm: add PWM controller driver
  PWM: atmel-pwm: add device tree binding document

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   41 ++
 drivers/pwm/Kconfig                                |    9 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-atmel.c                            |  398 ++++++++++++++++++++
 4 files changed, 449 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
 create mode 100644 drivers/pwm/pwm-atmel.c

-- 
1.7.9.5
