From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 31 Aug 2015 15:13:06 +0200
Subject: [PATCH 1/3] ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay
In-Reply-To: <20150831124314.GE14459@lunn.ch>
References: <1440866805-31731-1-git-send-email-simon.guinot@sequanux.org>
 <1440866805-31731-2-git-send-email-simon.guinot@sequanux.org>
 <20150831124314.GE14459@lunn.ch>
Message-ID: <20150831131306.GO30993@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 31, 2015 at 02:43:14PM +0200, Andrew Lunn wrote:
> On Sat, Aug 29, 2015 at 06:46:43PM +0200, Simon Guinot wrote:
> > From: Vincent Donnefort <vdonnefort@gmail.com>
> > 
> > This patch adds DT support for the Seagate NAS 2 and 4-Bay (n090201 and
> > n090401).
> > 
> > Chipset list (common):
> > - SoC Marvell Armada 370 88F6707, CPU @1.2GHz
> > - SDRAM memory: 512MB DDR3 600MHz (16-bits bandwidth)
> > - NAND flash 256MB, 8-bits (Micron MT29F2G08AAB or Hinyx H27U2G8F2CTR-BC)
> > - 2 SATA II ports (SoC)
> > - 1 Ethernet Gigabit ports (PHY Marvell 88E1518)
> > - 2 USB3 host ports (PCIe controller ASM1042)
> > - GPIO fan (4 speeds)
> > - External I2C RTC (MCP7940NT)
> > - 3 push buttons (power, backup and reset)
> > - 2 SATA LEDs (bi-color, blue and red)
> > - 1 power LED (bi-color, blue and red)
> > 
> > Only on 4-Bay models:
> > - 2 extra SATA III ports (PCIe AHCI controller Marvell 88SE9170)
> > - 1 extra Ethernet Gigabit ports (PHY Marvell 88E1518)
> > - I2C GPIO expander (PCA9554A)
> > - 2 extra SATA LEDs (bi-color, blue and red)
> > 
> > Note that support for the white SATA LEDs associated with HDDs 0 and 1
> > is missing. A dedicated LED driver is needed.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
> > ---
> >  arch/arm/boot/dts/Makefile                |   2 +
> >  arch/arm/boot/dts/armada-370-n090201.dts  |  28 ++++
> >  arch/arm/boot/dts/armada-370-n090401.dts  | 124 ++++++++++++++++
> >  arch/arm/boot/dts/armada-370-n090x01.dtsi | 232 ++++++++++++++++++++++++++++++
> >  4 files changed, 386 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/armada-370-n090201.dts
> >  create mode 100644 arch/arm/boot/dts/armada-370-n090401.dts
> >  create mode 100644 arch/arm/boot/dts/armada-370-n090x01.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 233159d2eaab..0a46613e90d2 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -699,6 +699,8 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
> >  	armada-370-db.dtb \
> >  	armada-370-dlink-dns327l.dtb \
> >  	armada-370-mirabox.dtb \
> > +	armada-370-n090201.dtb \
> > +	armada-370-n090401.dtb \
> >  	armada-370-netgear-rn102.dtb \
> >  	armada-370-netgear-rn104.dtb \
> >  	armada-370-rd.dtb \
> > diff --git a/arch/arm/boot/dts/armada-370-n090201.dts b/arch/arm/boot/dts/armada-370-n090201.dts
> > new file mode 100644
> > index 000000000000..b92b1ee067d6
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/armada-370-n090201.dts
> > @@ -0,0 +1,28 @@
> > +/*
> > + * Device Tree file for Seagate NAS 2-Bay (n090201)
> > + *
> > + * Copyright (C) 2015 Seagate
> > + *
> > + * Author: Vincent Donnefort <vdonnefort@gmail.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "armada-370-n090x01.dtsi"
> > +
> > +/ {
> > +	model = "Seagate NAS 2-Bay";

Hi Andrew,

> 
> On a similar line to Jason's comment. I'm sure Seagate has/is going to
> have more than this 2-bay NAS. Can we have a more descriptive model
> string here?

It may sound crazy but I have nothing more than the hardware and product
names which are respectively "n090201" and "Seagate NAS 2-Bay" for this
board.

Maybe I could mix them both in the model string:
"Seagate NAS 2-Bay (n090201)" ?

> 
> I could imagine an installer which looks through the list of available
> DT blobs and creates a list showing the model and compatible string,
> and asks the user, which should it use.

I can too.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150831/81d47cba/attachment.sig>
