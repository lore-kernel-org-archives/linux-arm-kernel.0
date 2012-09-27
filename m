From: Barry.Song@csr.com (Barry Song)
Date: Thu, 27 Sep 2012 17:53:14 +0800
Subject: [PATCH 0/6] pinctrl: sirf: a bundle of fix, cleanup and upgrade
Message-ID: <1348739594-21034-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix some issues in SiRF pinctrl driver and also make it
support the new SiRFmarco SMP SoCs.

Tested by DM9000 using one GPIO as IO address/data switch and another
GPIO as external IRQ source on SiRFmarco board.

Barry Song (6):
  pinctrl: sirf: fix a typo in sirfsoc_gpio_probe
  pinctrl: sirf: add missing pins to pinctrl list
  pinctrl: sirf: fix spinlock deadlock in sirfsoc_gpio_set_input
  pinctrl: sirf: initialize the irq_chip pointer of pinctrl_gpio_range
  pinctrl: sirf: add lost chained_irq_enter and exit in
    sirfsoc_gpio_handle_irq
  pinctrl: sirf: enable the driver support new SiRFmarco SoC

 drivers/pinctrl/Kconfig        |    4 +-
 drivers/pinctrl/pinctrl-sirf.c |   71 ++++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 19 deletions(-)



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
