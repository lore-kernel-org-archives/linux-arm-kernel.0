From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Fri, 15 Mar 2013 20:36:13 +0100
Subject: [PATCH v2 0/2] refactoring for mask_cache
In-Reply-To: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
Message-ID: <1363376175-22312-1-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,
here is a 2-patch set to address the issue found with Orion,
hoping I understood correctly what Thomas meant.
Even though I'm also providing changes for mvebu, I only
tested the patch on a 3.0.40 kernel with the plat-orion/gpio.c driver.
We currently do not have a working 3.6+ configuration for our Kirkwood
boards (3.6 is apparently where this mvebu gpio driver was introduced),
so I would be glad if someone could give it a try.
I also have no idea whether the three Marvell variants all have separate
mask registers.

Gerlando Falauto (2):
  genirq: cosmetic: remove cur_regs
  genirq: move mask_cache into struct irq_chip_type

 arch/arm/plat-orion/gpio.c            |    3 +-
 arch/arm/plat-samsung/irq-vic-timer.c |    6 ++--
 arch/mips/jz4740/irq.c                |    3 +-
 drivers/gpio/gpio-mvebu.c             |   23 +++++++------
 include/linux/irq.h                   |    7 ++--
 kernel/irq/generic-chip.c             |   57 +++++++++++++++++++++------------
 6 files changed, 63 insertions(+), 36 deletions(-)

-- 
1.7.10.1
