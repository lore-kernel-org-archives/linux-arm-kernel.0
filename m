From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Mar 2013 21:50:31 +0900
Subject: [PATCH 01/03] ARM: shmobile: APE6EVM base support V2
In-Reply-To: <CANqRtoTDGUnSA5J4Y1TNLUUL1jC_CmCEOdwa49Z2JtJ2vj3iUA@mail.gmail.com>
References: <20130318150953.28231.73454.sendpatchset@w520>
 <20130318151002.28231.37531.sendpatchset@w520>
 <20130319072532.GA19741@verge.net.au>
 <CANqRtoTDGUnSA5J4Y1TNLUUL1jC_CmCEOdwa49Z2JtJ2vj3iUA@mail.gmail.com>
Message-ID: <20130320125030.GA16436@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Tue, Mar 19, 2013 at 07:15:22PM +0900, Magnus Damm wrote:
> On Tue, Mar 19, 2013 at 4:25 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Mar 19, 2013 at 12:10:02AM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> V2 of APE6EVM base board support making use of
> >> 1 GiB of memory, the SCIFA0 serial port and
> >> ARM architected timer.
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> ---
> >>
> >>  Changes since V1:
> >>  - Sorted headers
> >>  - Use ape6evm_add_standard_devices() to setup SoC devices and clocks
> >>
> >>   Written against "next" renesas.git 811689afc214564c4a5f238ecf4d8bdc0e52b615
> >>
> >>  Depends on the following series:
> >>  [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V2
> >>
> >>  Does not depend on:
> >>  [PATCH 00/02] sh-pfc: Initial r8a73a4 PFC support
> >>
> >> arch/arm/boot/dts/Makefile             |    1
> >>  arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   26 ++++++++++++++++++
> >>  arch/arm/mach-shmobile/Kconfig         |    8 ++++-
> >>  arch/arm/mach-shmobile/Makefile        |    1
> >>  arch/arm/mach-shmobile/board-ape6evm.c |   46 ++++++++++++++++++++++++++++++++
> >>  5 files changed, 81 insertions(+), 1 deletion(-)
> >>
> >> --- 0001/arch/arm/boot/dts/Makefile
> >> +++ work/arch/arm/boot/dts/Makefile   2013-03-18 21:44:34.000000000 +0900
> >> @@ -139,6 +139,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
> >>       r8a7779-marzen-reference.dtb \
> >>       sh73a0-kzm9g.dtb \
> >>       sh73a0-kzm9g-reference.dtb \
> >> +     r8a73a4-ape6evm.dtb \
> >>       sh7372-mackerel.dtb
> >>  dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
> >>       socfpga_vt.dtb
> >> --- /dev/null
> >> +++ work/arch/arm/boot/dts/r8a73a4-ape6evm.dts        2013-03-18 21:44:35.000000000 +0900
> >> @@ -0,0 +1,26 @@
> >> +/*
> >> + * Device Tree Source for the APE6EVM board
> >> + *
> >> + * Copyright (C) 2013 Renesas Solutions Corp.
> >> + *
> >> + * This file is licensed under the terms of the GNU General Public License
> >> + * version 2.  This program is licensed "as is" without any warranty of any
> >> + * kind, whether express or implied.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +/include/ "r8a73a4.dtsi"
> >> +
> >> +/ {
> >> +     model = "APE6EVM";
> >> +     compatible = "renesas,ape6evm", "renesas,r8a73a4";
> >> +
> >> +     chosen {
> >> +             bootargs = "console=ttySC0,115200 ignore_loglevel";
> >
> > I think that earlyprintk=sh-sci.0,11520 go in here.
> 
> Thanks for checking, but we're not making use of earlyprintk on
> r8a73a4. So adding this parameter will not make any difference, just
> potential confusion IMO.
> 
> On r8a73a4 the SCIF ports are added as regular device drivers at
> ->init_machine() timing. With this approach transition to DT in the
> future will be just a small step.

Thanks for the clarification.
