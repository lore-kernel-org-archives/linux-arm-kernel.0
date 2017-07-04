From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 4 Jul 2017 22:00:21 +0800
Subject: [PATCH V3 0/2] timer: add imx tpm timer support
Message-ID: <1499176823-4421-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Timer/PWM Module (TPM) supports input capture, output compare,
and the generation of PWM signals to control electric motor and power
management applications. The counter, compare and capture registers
are clocked by an asynchronous clock that can remain enabled in low
power modes. TPM can support global counter bus where one TPM drives
the counter bus for the others, provided bit width is the same.

This patch only adds the timer support. PWM would be added later.

ChangeLog:
v2->v3:
 * address a few minor comments from Daniel Lezcano
 * add more explaination on ETIME check in commit message
v1->v2:
 * change to readl/writel from __raw_readl/writel according to Arnd's
   suggestion to avoid endian issue
 * add help information in Kconfig
 * add more error checking

Dong Aisheng (2):
  dt-bindings: timer: add nxp tpm timer binding doc
  timer: imx-tpm: add imx tpm timer support

 .../devicetree/bindings/timer/nxp,tpm-timer.txt    |  28 +++
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-imx-tpm.c                | 233 +++++++++++++++++++++
 4 files changed, 270 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
 create mode 100644 drivers/clocksource/timer-imx-tpm.c

-- 
2.7.4
