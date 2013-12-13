From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 13 Dec 2013 13:45:33 +0100
Subject: [PATCH 4/4] ARM: dts: imx6qdl: add support for Ka-Ro TX6 modules
In-Reply-To: <20131213121308.GT18380@S2101-09.ap.freescale.net>
References: <1386854880-21805-1-git-send-email-LW@KARO-electronics.de>
 <1386854880-21805-5-git-send-email-LW@KARO-electronics.de>
 <20131213121308.GT18380@S2101-09.ap.freescale.net>
Message-ID: <20131213134533.51c84319@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo wrote:
> Lothar,
> 
> Please check the patch against those comments that I put on the TX53
> patches.  A couple of comments embedded below.
> 
> On Thu, Dec 12, 2013 at 02:28:00PM +0100, Lothar Wa?mann wrote:
> ...
> > @@ -0,0 +1,350 @@
> > +/*
> > + * Copyright 2013 Lothar Wa?mann <LW@KARO-electronics.de>
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx6dl.dtsi"
> > +#include "imx6qdl-tx6.dtsi"
> > +
> > +/ {
> > +	model = "Ka-Ro electronics TX6DL Module";
> > +	compatible = "fsl,imx6dl-tx6dl", "fsl,imx6dl";
> 
> karo,imx6dl-tx6dl
> 
Of course...

> <snip>
> 
> > +&iomuxc {
> > +	display {
> > +		pinctrl_disp0_1: disp0grp-1 {
> > +			fsl,pins = <
> > +				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
> > +				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
> > +				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
> > +				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
> > +				/* PAD DISP0_DAT0 is used for the Flexcan transceiver control */
> 
> So how will this pingrp be used, without DATA00?
> 
The HW design of a baseboard for this module is somewhat unfortunate in
that it uses the LCD0 pin as Enable pin for the flexcan transceiver.
In this configuration the LCD will be missing the LSB.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
