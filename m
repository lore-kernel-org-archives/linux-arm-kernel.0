From: stigge@antcom.de (Roland Stigge)
Date: Sun, 22 Apr 2012 12:37:16 +0200
Subject: [GIT PULL] i2c: pnx: device tree conversion
Message-ID: <4F93DF5C.5080503@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this is the series of the 4 patches adding device tree support to i2c-pnx
(used by LPC32xx) that Wolfram Sang already applied to the i2c subsystem.
Since both drivers/i2c/ and mach-lpc32xx are touched here, there will
probably be conflicts that you need to be aware of.

I'm posting this again for arm-soc since the actual mach-lpc32xx specific
DT conversion builds upon those changes (see next pull request), especially
in arch/arm/mach-lpc32xx/common.c.

Wolfram already gave permission to merge this via arm-soc, but please
coordinate and tell me if I can help resolving this.

Thanks in advance,

Roland


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/i2c

for you to fetch changes up to b41a216dafe4dd23c95cb4203de288f773a097a6:

  i2c: Add device tree support to i2c-pnx.c (2012-04-22 11:59:47 +0200)

----------------------------------------------------------------
Roland Stigge (4):
      i2c: pnx: Disable clk in suspend
      i2c-pnx.c: Use resources in platforms
      i2c-pnx.c: Remove duplicated i2c.h
      i2c: Add device tree support to i2c-pnx.c

 Documentation/devicetree/bindings/i2c/pnx.txt |   36 ++++++
 arch/arm/mach-lpc32xx/common.c                |   67 +++++++----
 arch/arm/mach-lpc32xx/include/mach/i2c.h      |   63 ----------
 arch/arm/mach-pnx4008/i2c.c                   |   64 ++++++----
 arch/arm/mach-pnx4008/include/mach/i2c.h      |   64 ----------
 drivers/i2c/busses/i2c-pnx.c                  |  160 ++++++++++++++++++-------
 include/linux/i2c-pnx.h                       |   10 +-
 7 files changed, 238 insertions(+), 226 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/pnx.txt
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/i2c.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/i2c.h
