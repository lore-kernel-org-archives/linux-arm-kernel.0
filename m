From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 19 Jul 2011 09:12:07 +0200
Subject: [PATCH 0/7] support DT on ARCH-MMP
In-Reply-To: <1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
References: <2011071901>
	<1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110719091207.7cb06f47@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Tue, 19 Jul 2011 10:24:43 +0800, Haojian Zhuang wrote:
> 
> It's used to support DT on ARCH-MMP.
> 
> Haojian Zhuang (7):
>       ARM: mmp: parse irq from DT
>       ARM: mmp: append MMP_USE_OF config
>       ARM: mmp: support DT on both dkb and brownstone
>       tty: serial: support device tree in pxa
>       tty: serial: check ops before registering console
>       i2c: pxa: support i2c controller from DT
>       i2c: pxa: support to parse property
> 
>  .../devicetree/bindings/arm/marvell/boards.txt     |    7 +
>  .../devicetree/bindings/arm/marvell/intc.txt       |  120 ++++++++++
>  .../devicetree/bindings/i2c/pxa255-i2c.txt         |   36 +++
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/boot/dts/mmp2-brownstone.dts              |  242 ++++++++++++++++++++
>  arch/arm/boot/dts/ttc-dkb.dts                      |   80 +++++++
>  arch/arm/mach-mmp/Kconfig                          |    7 +
>  arch/arm/mach-mmp/Makefile                         |    6 +
>  arch/arm/mach-mmp/boards.c                         |  159 +++++++++++++
>  arch/arm/mach-mmp/common.h                         |    1 +
>  arch/arm/mach-mmp/include/mach/irqs.h              |    4 +
>  arch/arm/mach-mmp/intc.c                           |  223 ++++++++++++++++++
>  drivers/i2c/busses/i2c-pxa.c                       |   78 +++++--
>  drivers/tty/serial/Kconfig                         |    4 +-
>  drivers/tty/serial/of_serial.c                     |   12 +
>  drivers/tty/serial/pxa.c                           |   95 ++++++++-
>  include/linux/serial_pxa.h                         |   17 ++
>  17 files changed, 1065 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/boards.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/intc.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/pxa255-i2c.txt
>  create mode 100644 arch/arm/boot/dts/mmp2-brownstone.dts
>  create mode 100644 arch/arm/boot/dts/ttc-dkb.dts
>  create mode 100644 arch/arm/mach-mmp/boards.c
>  create mode 100644 arch/arm/mach-mmp/intc.c
>  create mode 100644 include/linux/serial_pxa.h

I am not involved in this in any way so please don't include me in the
Cc list.

Thanks,
-- 
Jean Delvare
