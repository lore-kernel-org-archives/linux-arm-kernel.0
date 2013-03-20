From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 20 Mar 2013 23:45:04 +0900
Subject: [PATCH 01/03] ARM: shmobile: APE6EVM base support V2
In-Reply-To: <20130320125057.GB16436@verge.net.au>
References: <20130318150953.28231.73454.sendpatchset@w520>
 <20130318151002.28231.37531.sendpatchset@w520>
 <20130319072532.GA19741@verge.net.au>
 <20130319075053.GA14668@verge.net.au>
 <CANqRtoRkKB-5GxWN_uXN6ansA33koX743Gr0EsBeEVSd0uwgMg@mail.gmail.com>
 <20130320125057.GB16436@verge.net.au>
Message-ID: <CANqRtoQVdT7JeT=00WMp7OwVnX=-v1htZ8=jx+GBtOWRf9hMKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 9:50 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Mar 19, 2013 at 07:18:18PM +0900, Magnus Damm wrote:
>> On Tue, Mar 19, 2013 at 4:50 PM, Simon Horman <horms@verge.net.au> wrote:
>> > On Tue, Mar 19, 2013 at 04:25:33PM +0900, Simon Horman wrote:
>> >> On Tue, Mar 19, 2013 at 12:10:02AM +0900, Magnus Damm wrote:
>> >> > From: Magnus Damm <damm@opensource.se>
>> >> >
>> >> > V2 of APE6EVM base board support making use of
>> >> > 1 GiB of memory, the SCIFA0 serial port and
>> >> > ARM architected timer.
>> >> >
>> >> > Signed-off-by: Magnus Damm <damm@opensource.se>
>> >> > ---
>> >> >
>> >> >  Changes since V1:
>> >> >  - Sorted headers
>> >> >  - Use ape6evm_add_standard_devices() to setup SoC devices and clocks
>> >> >
>> >> >   Written against "next" renesas.git 811689afc214564c4a5f238ecf4d8bdc0e52b615
>> >> >
>> >> >  Depends on the following series:
>> >> >  [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V2
>> >> >
>> >> >  Does not depend on:
>> >> >  [PATCH 00/02] sh-pfc: Initial r8a73a4 PFC support
>> >> >
>> >> > arch/arm/boot/dts/Makefile             |    1
>> >> >  arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   26 ++++++++++++++++++
>> >> >  arch/arm/mach-shmobile/Kconfig         |    8 ++++-
>> >> >  arch/arm/mach-shmobile/Makefile        |    1
>> >> >  arch/arm/mach-shmobile/board-ape6evm.c |   46 ++++++++++++++++++++++++++++++++
>> >> >  5 files changed, 81 insertions(+), 1 deletion(-)
>> >> >
>> >> > --- /dev/null
>> >> > +++ work/arch/arm/boot/dts/r8a73a4-ape6evm.dts      2013-03-18 21:44:35.000000000 +0900
>> >> > @@ -0,0 +1,26 @@
>> >> > +/*
>> >> > + * Device Tree Source for the APE6EVM board
>> >> > + *
>> >> > + * Copyright (C) 2013 Renesas Solutions Corp.
>> >> > + *
>> >> > + * This file is licensed under the terms of the GNU General Public License
>> >> > + * version 2.  This program is licensed "as is" without any warranty of any
>> >> > + * kind, whether express or implied.
>> >> > + */
>> >> > +
>> >> > +/dts-v1/;
>> >> > +/include/ "r8a73a4.dtsi"
>> >> > +
>> >> > +/ {
>> >> > +   model = "APE6EVM";
>> >> > +   compatible = "renesas,ape6evm", "renesas,r8a73a4";
>> >> > +
>> >> > +   chosen {
>> >> > +           bootargs = "console=ttySC0,115200 ignore_loglevel";
>> >>
>> >> I think that earlyprintk=sh-sci.0,11520 go in here.
>> >
>> > Also, to be consistent with the dts of other shmobile boards
>> > could you add root=/dev/nfs ip=dhcp. This history behind this
>> > is that many boards defaulted to using nfsroot in their defconfigs,
>> > a reasonable default IMHO, and recently the command line for all
>> > boards that boot using DT was moved from their defconfig
>> > to their .dtsi in preparation for defconfig consolidation.
>>
>> Sounds like a good idea. Network is however not existing until pretty
>> late in the series. How about adding it in that patch that includes
>> SMSC ethernet support?
>
> Yes, that sounds reasonable to me.

Thanks. I will include that change in V3 together with a bug fix for
the SCIF ports. Also, if there is any suggestion about the the split
of platform device vs DT then I can also rework that portion of the
code. And yes, will need to update the PFC with PINCTRL support too.

Cheers,

/ magnus
