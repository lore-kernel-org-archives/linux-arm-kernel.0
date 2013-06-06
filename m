From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 6 Jun 2013 10:24:13 +0200
Subject: [PATCH v3 0/7] pcmcia: at91_cf: clean up and add DT support
Message-ID: <cover.1370506678.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches clean up at91_cf a bit and add DT bindings.
They are based on a previous series from Joachim Eastwood and other cleanup
patches by Fabio and Laurent.
I have collected them together as they are lying around for some time.

Greg kindly told me that he can take them through his char/misc driver
tree, so I resend the series.

Thanks for your help, best regards.

v3: rebased on top of 3.10-rc4

v2: add 2 more cleanup patches:
	- move to module_platform_driver_probe()
	- little trivial indentation fix

Fabio Porcedda (1):
  pcmcia: at91_cf: use module_platform_driver_probe()

Joachim Eastwood (5):
  pcmcia: at91_cf: fix gpio_get_value in at91_cf_get_status
  pcmcia: at91_cf: convert to dev_ print functions
  pcmcia: at91_cf: use devm_ functions for allocations
  pcmcia: at91_cf: clean up header includes
  pcmcia: at91_cf: add support for DT

Laurent Navet (1):
  pcmcia/trivial: at91_cf: fix checkpatch error

 .../devicetree/bindings/ata/atmel-at91_cf.txt      |  19 +++
 drivers/pcmcia/Kconfig                             |   2 +-
 drivers/pcmcia/at91_cf.c                           | 176 ++++++++++-----------
 3 files changed, 108 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/atmel-at91_cf.txt

-- 
1.8.2.2
