From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 23 May 2014 20:23:06 +0200
Subject: [PATCH v3 0/4] DT support for LaCie 2Big and 5Big Network v2
In-Reply-To: <20140523180242.GM6755@kw.sim.vm.gnt>
References: <1399839712-2416-1-git-send-email-andrew@lunn.ch>
 <20140523180242.GM6755@kw.sim.vm.gnt>
Message-ID: <20140523182306.GD31314@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 08:02:42PM +0200, Simon Guinot wrote:
> On Sun, May 11, 2014 at 10:21:48PM +0200, Andrew Lunn wrote:
> > v3:
> > gpio_poweroff -> gpio-poweroff, etc.
> > Add stdout-path
> > Remove pinctrl property from spi, set in kirkwood.dtsi.
> > 
> > Andrew Lunn (4):
> >   ARM: Kirkwood: Add board file for netxbig LEDs
> >   ARM: Kirkwood: Add DT descriptions for net2big and net5big.
> >   ARM: mvebu: Add LaCie 2Big and 5Big Network v2
> >   ARM: multi_v5: Enable LaCie 2Big and 5Big Network v2
> > 
> >  arch/arm/boot/dts/Makefile              |   2 +
> >  arch/arm/boot/dts/kirkwood-net2big.dts  |  30 +++++
> >  arch/arm/boot/dts/kirkwood-net5big.dts  |  83 ++++++++++++++
> >  arch/arm/boot/dts/kirkwood-netxbig.dtsi | 166 +++++++++++++++++++++++++++
> >  arch/arm/configs/multi_v5_defconfig     |   1 +
> >  arch/arm/configs/mvebu_v5_defconfig     |   1 +
> >  arch/arm/mach-mvebu/Kconfig             |   7 ++
> >  arch/arm/mach-mvebu/Makefile            |   1 +
> >  arch/arm/mach-mvebu/board-netxbig.c     | 191 ++++++++++++++++++++++++++++++++
> >  arch/arm/mach-mvebu/board.h             |   5 +
> >  arch/arm/mach-mvebu/kirkwood.c          |   3 +
> >  11 files changed, 490 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi
> >  create mode 100644 arch/arm/mach-mvebu/board-netxbig.c
> 
> Hi Andrew,
> 
> I have successfully tested your patch series (on the top of Linux
> 3.15-rc6) on a 2Big Network v2 board.

Great, thanks.

> Unfortunately, I failed to test the 5Big Network v2 support. My power
> supply died :( And since the connector is very specific, I have to wait
> until next Tuesday to get an another one.

O.K. I think we have missed the merge window for this cycle anyway, so
take your time.

> Moreover, I have a question. The DT support for the d2 Network v2
> board (d2net_v2) is still missing. Since this board is very close
> from the 2Big Network v2, I think it should be included in this
> patch series. Do you want me to take care of that ?

Humm, i thought Thomas had done that conversion. However, it looks
like his patches never got picked up:

http://www.spinics.net/lists/arm-kernel/msg263520.html

It would be great if you can finish them off.

   Andrew
