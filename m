From: andy@aeruder.net (Andrew Ruder)
Date: Wed, 29 Jan 2014 09:46:22 -0600
Subject: [BUG] reproducable ubifs reboot assert and corruption
In-Reply-To: <52E8AE25.8080502@nod.at>
References: <20140122051510.GB17284@gmail.com>
 <CAFLxGvwmzftdQKSjjjwpFLS8g3EJqMrQ2gU2scBsh2MvG7Wyyw@mail.gmail.com>
 <20140127163939.GA27809@gmail.com>
 <20140129053238.GA6035@gmail.com> <52E8AE25.8080502@nod.at>
Message-ID: <20140129154622.GB7278@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 08:30:45AM +0100, Richard Weinberger wrote:
> BTW: Can you please share your .config?

No problem.  FYI, this is for a board that is still in development so
not all my changes have been submitted for inclusion yet.  I would be
happy to share the changes now if necessary but I've attached the --stat
to show that as far as mtd/ubifs goes, i'm basically running a stock
v3.12:

% git diff --stat v3.12..HEAD
 Documentation/devicetree/bindings/usb/pxa-usb.txt |    5 +-
 arch/arm/boot/dts/Makefile                        |    2 +
 arch/arm/boot/dts/pxa270-elecsys_z2.dts           |  330 ++++++
 arch/arm/boot/dts/pxa270-elecsys_z4.dts           |  434 +++++++
 arch/arm/boot/dts/pxa27x.dtsi                     |   13 +-
 arch/arm/boot/dts/pxa2xx.dtsi                     |   14 +-
 arch/arm/boot/dts/pxa3xx.dtsi                     |    4 +
 arch/arm/configs/elecsys_z2_defconfig             | 3089 +++++++++++++++
 arch/arm/mach-pxa/Kconfig                         |   18 +
 arch/arm/mach-pxa/Makefile                        |    3 +-
 arch/arm/mach-pxa/generic.c                       |    3 +-
 arch/arm/mach-pxa/include/mach/hardware.h         |    2 +-
 arch/arm/mach-pxa/irq.c                           |    8 +-
 arch/arm/mach-pxa/{pxa-dt.c => pxa27x-dt.c}       |   44 +-
 arch/arm/mach-pxa/pxa27x.c                        |   25 +-
 arch/arm/mach-pxa/{pxa-dt.c => pxa3xx-dt.c}       |   11 +-
 arch/arm/mach-pxa/sleep.S                         |    2 +-
 drivers/irqchip/Kconfig                           |    8 +
 drivers/irqchip/Makefile                          |    1 +
 drivers/irqchip/irq-zeus.c                        |  192 +++
 drivers/mmc/host/pxamci.c                         |   33 +-
 drivers/net/ethernet/8390/ne.c                    |    4 +-
 drivers/net/ethernet/davicom/dm9000.c             |   68 +-
 drivers/tty/serial/pxa.c                          |    6 +-
 24 files changed, 4222 insertions(+), 97 deletions(-)

And the .config I'm using is attached.

Thanks,
Andy



-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/x-gunzip
Size: 14745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140129/c86abdca/attachment.bin>
