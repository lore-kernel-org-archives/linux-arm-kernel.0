From: bs14@csr.com (Barry Song)
Date: Tue, 26 Jul 2011 01:13:11 -0700
Subject: [RFC PATCH 0/2] add pinmux and gpio for CSR SiRFprimaII
Message-ID: <1311667993-27189-1-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following two patches add pinmux and gpio support for CSR SiRFprimaII.

Now the pinmux subsystem of Linus Walleij, so patch 1 isn't based on it yet.
But it is easy to move that to use new framework once pinmux subsystem is merged.

Rongjun Ying (1):
  ARM: CSR: Add pinmux support for SiRFprimaII

Yuping Luo (1):
  GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller

 arch/arm/boot/dts/prima2-cb.dts               |    2 +-
 arch/arm/mach-prima2/Makefile                 |    1 +
 arch/arm/mach-prima2/include/mach/gpio.h      |   34 +
 arch/arm/mach-prima2/include/mach/irqs.h      |   11 +
 arch/arm/mach-prima2/include/mach/regs-gpio.h |   30 +
 arch/arm/mach-prima2/pinmux.c                 |  824 +++++++++++++++++++++++++
 drivers/gpio/Kconfig                          |    6 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-sirf.c                      |  529 ++++++++++++++++
 9 files changed, 1437 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-prima2/include/mach/gpio.h
 create mode 100644 arch/arm/mach-prima2/include/mach/regs-gpio.h
 create mode 100644 arch/arm/mach-prima2/pinmux.c
 create mode 100644 drivers/gpio/gpio-sirf.c



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
