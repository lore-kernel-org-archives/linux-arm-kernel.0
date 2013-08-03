From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 13:12:35 -0400
Subject: [PATCHv2 7/9] ARM: kirkwood: convert LaCie Net{2, 5}Big v2
 platforms to DT
In-Reply-To: <20130802212553.GA20330@kw.sim.vm.gnt>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130802212553.GA20330@kw.sim.vm.gnt>
Message-ID: <20130803171235.GK5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 11:25:53PM +0200, Simon Guinot wrote:
> On Thu, Aug 01, 2013 at 05:07:33PM +0200, Thomas Petazzoni wrote:
> > This commit converts the LaCie Net2big and Net5Big Kirkwood boards to
> > use a Device Tree representation. All devices are converted to use a
> > DT representation, except the GPIO extension leds that use a special
> > leds-netxbig driver that does not yet have a DT binding.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/Makefile                |   2 +
> >  arch/arm/boot/dts/kirkwood-net2big-v2.dts | 219 ++++++++++++++++
> >  arch/arm/boot/dts/kirkwood-net5big-v2.dts | 265 +++++++++++++++++++
> >  arch/arm/mach-kirkwood/Kconfig            |  26 +-
> >  arch/arm/mach-kirkwood/Makefile           |   4 +-
> >  arch/arm/mach-kirkwood/board-dt.c         |   4 +
> >  arch/arm/mach-kirkwood/board-netxbig_v2.c | 199 ++++++++++++++
> >  arch/arm/mach-kirkwood/common.h           |   6 +
> >  arch/arm/mach-kirkwood/netxbig_v2-setup.c | 422 ------------------------------
> >  9 files changed, 709 insertions(+), 438 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/kirkwood-net2big-v2.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-net5big-v2.dts
> >  create mode 100644 arch/arm/mach-kirkwood/board-netxbig_v2.c
> >  delete mode 100644 arch/arm/mach-kirkwood/netxbig_v2-setup.c
...
> > +		serial at 12000 {
> > +			pinctrl-0 = <&pmx_uart0>;
> > +			pinctrl-names = "default";
> > +			clock-frequency = <200000000>;
> 
> The serial clock-frequency is 166666667 for the net2big_v2 as well as
> the TCLK frequency. It could smart to inherit the clock frequencies (if
> not given) from the TCLK.

iirc, I wrote a patch a release or two ago removing the clock-frequency
from the serial nodes because it jacked up the of_serial driver.
Something about if it was specified, the driver skipped something
critical.

Sorry I don't have it on hand atm, I'm away from my development station.

thx,

Jason.
