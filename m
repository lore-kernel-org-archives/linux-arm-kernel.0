From: johnlinn@comcast.net (johnlinn at comcast.net)
Date: Mon, 20 Jun 2011 18:02:51 +0000 (UTC)
Subject: Pull request [V2] for Xilinx Zynq platform support
In-Reply-To: <344318725.107463.1308592752290.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Message-ID: <212298724.107665.1308592971231.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull this commit to support the Xilinx Zynq platform into your tree.

This patch has been out in the community and mailing list for a while.  It has
also been in linux-next for a while.

For V2, I corrected the mistakes Grant and Russell had pointed out.

Thanks,
John Linn


The following changes since commit 2c53b436a30867eb6b47dd7bab23ba638d1fb0d2:
  Linus Torvalds (1):
        Linux 3.0-rc3

are available in the git repository at:

  git://git.xilinx.com/arm-next

John Linn (1):
      ARM: Xilinx: Adding Xilinx board support

 Documentation/devicetree/bindings/arm/xilinx.txt |    7 +
 arch/arm/Kconfig                                 |   14 +
 arch/arm/Makefile                                |    2 +
 arch/arm/boot/dts/zynq-ep107.dts                 |   52 ++++
 arch/arm/mach-zynq/Makefile                      |    6 +
 arch/arm/mach-zynq/Makefile.boot                 |    3 +
 arch/arm/mach-zynq/board_dt.c                    |   37 +++
 arch/arm/mach-zynq/common.c                      |  102 ++++++++
 arch/arm/mach-zynq/common.h                      |   29 ++
 arch/arm/mach-zynq/include/mach/clkdev.h         |   32 +++
 arch/arm/mach-zynq/include/mach/debug-macro.S    |   36 +++
 arch/arm/mach-zynq/include/mach/entry-macro.S    |   30 +++
 arch/arm/mach-zynq/include/mach/hardware.h       |   18 ++
 arch/arm/mach-zynq/include/mach/io.h             |   33 +++
 arch/arm/mach-zynq/include/mach/irqs.h           |   21 ++
 arch/arm/mach-zynq/include/mach/memory.h         |   22 ++
 arch/arm/mach-zynq/include/mach/system.h         |   28 ++
 arch/arm/mach-zynq/include/mach/timex.h          |   23 ++
 arch/arm/mach-zynq/include/mach/uart.h           |   25 ++
 arch/arm/mach-zynq/include/mach/uncompress.h     |   51 ++++
 arch/arm/mach-zynq/include/mach/vmalloc.h        |   20 ++
 arch/arm/mach-zynq/include/mach/zynq_soc.h       |   48 ++++
 arch/arm/mach-zynq/timer.c                       |  298 ++++++++++++++++++++++
 arch/arm/mm/Kconfig                              |    2 +-
 24 files changed, 938 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/xilinx.txt
 create mode 100644 arch/arm/boot/dts/zynq-ep107.dts
 create mode 100644 arch/arm/mach-zynq/Makefile
 create mode 100644 arch/arm/mach-zynq/Makefile.boot
 create mode 100644 arch/arm/mach-zynq/board_dt.c
 create mode 100644 arch/arm/mach-zynq/common.c
 create mode 100644 arch/arm/mach-zynq/common.h
 create mode 100644 arch/arm/mach-zynq/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-zynq/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-zynq/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-zynq/include/mach/hardware.h
 create mode 100644 arch/arm/mach-zynq/include/mach/io.h
 create mode 100644 arch/arm/mach-zynq/include/mach/irqs.h
 create mode 100644 arch/arm/mach-zynq/include/mach/memory.h
 create mode 100644 arch/arm/mach-zynq/include/mach/system.h
 create mode 100644 arch/arm/mach-zynq/include/mach/timex.h
 create mode 100644 arch/arm/mach-zynq/include/mach/uart.h
 create mode 100644 arch/arm/mach-zynq/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-zynq/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-zynq/include/mach/zynq_soc.h
 create mode 100644 arch/arm/mach-zynq/timer.c
