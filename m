From: marex@denx.de (Marek Vasut)
Date: Thu, 19 Nov 2015 17:11:54 +0100
Subject: [PATCH 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <CAOMZO5C1oYge+TUKPYsgBRV75HVDwj42oAo27aaK-XqtHw8-7g@mail.gmail.com>
References: <1447840120-8513-1-git-send-email-marex@denx.de>
 <1447840120-8513-2-git-send-email-marex@denx.de>
 <CAOMZO5C1oYge+TUKPYsgBRV75HVDwj42oAo27aaK-XqtHw8-7g@mail.gmail.com>
Message-ID: <201511191711.54699.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 18, 2015 at 01:00:50 PM, Fabio Estevam wrote:
> Hi Marek,

Hi!

> On Wed, Nov 18, 2015 at 7:48 AM, Marek Vasut <marex@denx.de> wrote:
> > +++ b/arch/arm/boot/dts/imx6q-novena.dts
> > @@ -0,0 +1,825 @@
> > +/*
> > + * Copyright 2014 Sutajio Ko-Usagi PTE LTD
> > + * Copyright 2012 Freescale Semiconductor, Inc.
> > + * Copyright 2011 Linaro Ltd.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> 
> Could you make this GPL/X11 dual-license?

I'll talk to Sean about this, but I hope this is not a problem.

> Take a look at arch/arm/boot/dts/imx6qdl-cubox-i.dtsi for a reference.
> 
> > +&iomuxc {
> > +       audmux {
> > +               pinctrl_audmux_novena: audmuxgrp-novena {
> > +                       fsl,pins = <
> > +                               MX6QDL_PAD_CSI0_DAT7__AUD3_RXD 
> > 0x80000000 +                              
> > MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x80000000 +                            
> >   MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x80000000 +                          
> >     MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x80000000
> 
> Please avoid these 0x80000000 throughout this file.
> 
> We should better not rely on the IOMUX settings done in the bootloader.

Fixed, thanks!

Best regards,
Marek Vasut
