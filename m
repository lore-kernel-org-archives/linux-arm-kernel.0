From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 3 Aug 2014 15:04:30 +0200
Subject: Formal license ambiguity in arch/arm/boot/dts/sun?i-a*.dts
In-Reply-To: <20140731192016.GA6869@excalibur.cnev.de>
References: <20140731192016.GA6869@excalibur.cnev.de>
Message-ID: <20140803130430.GY3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 31, 2014 at 09:20:16PM +0200, Karsten Merker wrote:
> Hello,
> 
> I have today read the patch by Hans de Goede to add a dts file
> for the "Banana Pi" development board (see
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/276339.html)
> and have stumbled over the license declaration at the beginning:
> 
> > +/*
> > + * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> 
> The phrase "The code contained herein is licensed under the GNU
> General Public License" does not make explicitly clear under
> which version(s) of the GPL the code can be used.  From the
> following "You may obtain a copy of the GNU General Public
> License Version 2 or later at the following locations [...]" one
> can deduce that the intention is most probably to license the
> code unter GPL2+, but from a legal point of view this information
> should be an explicit part of the license statement itself, as
> strictly formally speaking the latter statement does only inform
> the reader where he can find the text of GPL2 and later GPL
> versions, but does not expressly apply them to the code.  This is
> of course a rather formalistic view and may well be seen as
> beancounting, but I have seen too many cases where formal license
> ambiguities have led to problems years later, so I proposed to
> Hans to change the wording in his patch to something more
> explicit, similar to the dts files for other arm platforms.
> 
> A phrasing like used in the GPL appendix ("This program is
> free software; you can redistribute it and/or modify it under the
> terms of the GNU General Public License as published by the Free
> Software Foundation; either version 2 of the License, or (at your
> option) any later version") would avoid any ambiguity.
> 
> Hans agreed that the current phrasing is not ideal and should
> probably be changed to something unabiguous but pointed out that a
> similar wording is used in all the other dts files for Allwinner
> SOCs (arch/arm/boot/dts/sun?i-a*.dts) and proposed to refer the
> issue to you as the Allwinner platform maintainer (with the
> linux-arm-kernel and devicetree lists in CC).

Thanks for reporting this.

>From a quick grep, the issue is actually broader than just
Allwinner. At least the following platforms seem to do the same:
  - mvebu
  - axm5516
  - bcm
  - berlin
  - ea3250
  - ecx-2000
  - highbank
  - imx / mxs
  - lpc32xx
  - phy3250
  - picoxcell
  - shmobile
  - rockchip
  - socfpga
  - spear
  - ste
  - zynq

Would you mind sending a patch to fix all these?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140803/34b07625/attachment-0001.sig>
