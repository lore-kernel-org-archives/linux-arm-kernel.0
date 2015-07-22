From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 22 Jul 2015 17:35:30 +0800
Subject: [PATCH v3 1/2] arm64: dts: Add dts files for Marvell Berlin4CT SoC
In-Reply-To: <55AF6017.6040407@arm.com>
References: <1437555470-6283-1-git-send-email-jszhang@marvell.com>
 <1437555470-6283-2-git-send-email-jszhang@marvell.com>
 <55AF6017.6040407@arm.com>
Message-ID: <20150722173530.5b7b6621@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sudeep,

On Wed, 22 Jul 2015 10:19:19 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> 
> 
> On 22/07/15 09:57, Jisheng Zhang wrote:
> > Add initial dtsi file to support Marvell Berlin4CT SoC with
> > quad Cortex-A53 CPUs.
> >
> > It also adds dts file for Marvell Berlin4CT DMP board which is
> > based on Berlin4CT SoC.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >   arch/arm64/boot/dts/Makefile                  |   1 +
> >   arch/arm64/boot/dts/marvell/Makefile          |   5 +
> >   arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts |  67 +++++++++++
> >   arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 164 ++++++++++++++++++++++++++
> >   4 files changed, 237 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/marvell/Makefile
> >   create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
> >   create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> >
> 
> [..]
> 
> > diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
> > new file mode 100644
> > index 0000000..58ed7f1
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
> > @@ -0,0 +1,67 @@
> 
> [..]
> 
> > +/dts-v1/;
> > +
> > +#include "berlin4ct.dtsi"
> > +
> > +/ {
> > +	model = "MARVELL BG4CT DMP BOARD";
> > +	compatible = "marvell,berlin4ct-dmp", "marvell,berlin4ct", "marvell,berlin";
> > +
> > +	chosen {
> > +		bootargs = "earlycon=uart8250,mmio32,0xf7fcd000";
> > +		stdout-path = "serial0:115200n8";
> 
> Just earlycon without any parameters will suffice. Currently earlycon
> parsing code has issues and it's being worked out[1]. The serial port
> details specified in stdout-path will be used by earlycon.
> 
> Regards,
> Sudeep
> 
> [1] https://lkml.org/lkml/2015/4/8/604

I just found all arm64 ports don't have bootargs, so neither earlycon, I will
follow this behavior. Will send out v4 later.

Thanks
