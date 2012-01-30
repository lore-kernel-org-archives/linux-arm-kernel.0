From: robherring2@gmail.com (Rob Herring)
Date: Mon, 30 Jan 2012 11:31:37 -0600
Subject: [PATCH v3 0/2] generic irq chip and pl061 domain support
Message-ID: <1327944699-29882-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series adds irq domain support for generic irq chip and updates
pl061 gpio to use it. This is has been significant re-worked from the
previous version based on Grant Likely's irq domain work and to make
the domain support optional as some arches don't use domains. A new 
function irq_setup_generic_chip_domain is added to setup a generic irq
chip with a domain.

Shawn, can you test on i.MX again. I think your case with multiple generic
irq chips for 1 device node should work, but I can't test that.

This is based on Grant Likely's irq domain work and is available here:

git://sources.calxeda.com/kernel/linux.git pl061-domain-v3

Rob

Rob Herring (2):
  irq: add irq_domain support to generic-chip
  gpio: pl061: enable interrupts with DT style binding

 .../devicetree/bindings/gpio/pl061-gpio.txt        |   15 +++
 drivers/gpio/gpio-pl061.c                          |   39 ++++---
 include/linux/irq.h                                |   10 ++
 kernel/irq/generic-chip.c                          |  134 +++++++++++++++++---
 4 files changed, 166 insertions(+), 32 deletions(-)

-- 
1.7.5.4
