From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  7 Jul 2017 10:54:33 +0900
Subject: [PATCH v4 0/2] add UniPhier thermal support
Message-ID: <1499392475-17304-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for CPU temperature monitor modules implemented
on UniPhier LD20 and PXs2 SoCs. This driver supports temperature monitoring
and alert function on the module.

Changes in v3:
- remove TMOD_MASK and use TMOD_WIDTH representing the bit width of TMOD

Changes in v2:
- add nsleep after starting and stopping PVT
- replace temperature calculation with sign_extend32()

Changes in v1:
- separate dts from this patchset as another patchset
- remove 'reg' description on the dt-bindings document
- fix the order of calling initialization functions
- replace mask bits to use GENMASK
- fix calculation of temperature because of not considering a negative value
- use devm_request_threaded_irq() instead of devm_request_irq() and
  separate a thread function from the interrupt handler
- add dependency to Kconfig
- set 120C to CRITICAL_TEMP_LIMIT as maximum temperature
- shrink each line of parameters to save the number of lines
- improve some comments and copyright description

Kunihiko Hayashi (2):
  dt-bindings: thermal: add binding documentation for UniPhier thermal
    monitor
  thermal: uniphier: add UniPhier thermal driver

 .../bindings/thermal/uniphier-thermal.txt          |  64 ++++
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/uniphier_thermal.c                 | 386 +++++++++++++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
 create mode 100644 drivers/thermal/uniphier_thermal.c

-- 
2.7.4
