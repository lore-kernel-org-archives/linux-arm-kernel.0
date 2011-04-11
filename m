From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 12:48:17 +0100
Subject: [RFC PATCH 0/5] Convert some ARM platforms to basic-mmio-gpio
Message-ID: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The basic-mmio-gpio driver has been extended in
<http://marc.info/?l=linux-kernel&m=130252092900804&w=2> to support a
larger wider of controllers and this series converts the ARM platforms
that do not implement I/O muxing in the GPIO driver or use the .to_irq
method of gpio_chip to use the driver.

Jamie Iles (5):
  gemini: convert to basic-mmio-gpio
  sa1100: convert to basic-mmio-gpio
  w90x900: convert to basic-mmio-gpio
  iop: convert to basic-mmio-gpio
  mxc: convert to basic-mmio-gpio

 arch/arm/include/asm/hardware/iop3xx.h     |    6 +-
 arch/arm/mach-gemini/gpio.c                |   83 +++++----------
 arch/arm/mach-iop32x/include/mach/iop32x.h |    2 +-
 arch/arm/mach-iop33x/include/mach/iop33x.h |    2 +-
 arch/arm/mach-sa1100/gpio.c                |   69 +++++--------
 arch/arm/mach-w90x900/gpio.c               |  162 ++++++++--------------------
 arch/arm/plat-iop/gpio.c                   |   89 ++++-----------
 arch/arm/plat-mxc/gpio.c                   |   96 +++++------------
 arch/arm/plat-mxc/include/mach/gpio.h      |    3 +-
 9 files changed, 153 insertions(+), 359 deletions(-)

-- 
1.7.4.2
