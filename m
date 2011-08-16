From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 16 Aug 2011 17:36:19 +0200
Subject: [GIT PULL] mmc: atmel rework for next
Message-ID: <4E4A8E73.7050705@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Please pull from:

git://github.com/at91linux/linux-2.6-at91.git nfe/mmc_atmel

This is a series that reworks the atmel-mci driver for a future merge of both at91_mci and atmel-mci drivers. Those patches have been discussed on the mailing-list.
I added a tiny at91_mci patch also sent last week.

Those changes are made on top of current linus' git tree (v3.1-rc2-64-g688d1b3).

Thanks.

Ludovic Desroches (8):
      mmc: atmel-mci: change namespace
      mmc: atmel-mci: change atmci_readl and atmci_writel macros
      mmc: atmel-mci: indentation
      mmc: atmel-mci: add pdc support and runtime capabilities detection
      mmc: atmel-mci: change atmci_start_command to atmci_send_command
      mmc: atmel-mci: use ATMEL_PDC_SCND_BUF_OFF instead of a literal value
      mmc: atmel-mci: correct sg buffer size evaluation
      mmc: atmel-mci: fix a potential issue about pending PDC interrupts

Nicolas Ferre (1):
      mmc: at91_mci: remove the use of irq_to_gpio

 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 drivers/mmc/host/at91_mci.c              |    6 +-
 drivers/mmc/host/atmel-mci-regs.h        |  220 +++++----
 drivers/mmc/host/atmel-mci.c             |  823 ++++++++++++++++++++----------
 include/linux/atmel-mci.h                |    4 +-
 include/linux/atmel_pdc.h                |    2 +
 6 files changed, 685 insertions(+), 372 deletions(-)



-- 
Nicolas Ferre
