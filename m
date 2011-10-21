From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Oct 2011 20:07:17 +0200
Subject: [PATCH] arm/imx: add missing include of asm/exception.h for avic.c
In-Reply-To: <8805141.r6GF1WOsYI@wuerfel>
References: <1319164380-23517-1-git-send-email-shawn.guo@linaro.org>
	<20111021072219.GH15299@pengutronix.de>
	<8805141.r6GF1WOsYI@wuerfel>
Message-ID: <20111021180717.GJ23421@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2011 at 06:38:32PM +0200, Arnd Bergmann wrote:
> On Friday 21 October 2011 09:22:19 Uwe Kleine-K?nig wrote:
> > 
> > On Fri, Oct 21, 2011 at 10:33:00AM +0800, Shawn Guo wrote:
> > > It adds missing include of asm/exception.h for avic.c to fix the
> > > compile error below.
> > > 
> > >   arch/arm/plat-mxc/avic.c:154:39: error: expected ?=?, ?,?, ?;?,
> > >   ?asm? or ?__attribute__? before ?avic_handle_irq?
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Arnd already posted a patch for that[1], but this one looks better.
> > 
> > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Ok, thanks!
> 
> I found the same problem in plat-mxc/tzic.c as well now.
> 
> Which branch should we apply the patch to? The header file was
> introduced in rmk's smp branch, but the usage was introduced in
> the imx/multi-irq branch.
> 
> Should I merge the smp branch into imx/multi-irq and fix up the
> breakage in the merge commit?

Ok, this one is already found. Putting it into the merge commit sounds
good.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
