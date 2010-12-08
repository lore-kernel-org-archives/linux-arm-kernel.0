From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 10:17:26 +0100
Subject: [PATCH v3 01/15] ARM: mxs: Add core definitions
In-Reply-To: <AANLkTik_03SYc5PDX2m+EA9qZcp12PKMtvbtyUGW6BH1@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-1-git-send-email-shawn.guo@freescale.com>
	<20101207201816.GA14775@pengutronix.de>
	<AANLkTik_03SYc5PDX2m+EA9qZcp12PKMtvbtyUGW6BH1@mail.gmail.com>
Message-ID: <20101208091726.GF18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 12:50:56PM +0800, Shawn Guo wrote:
> Hi Uwe,
> 
> 2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Wed, Dec 08, 2010 at 12:31:52AM +0800, Shawn Guo wrote:
> [...]
> >> +#ifndef __MACH_MX23_H__
> >> +#define __MACH_MX23_H__
> >> +
> >> +#ifndef __ASSEMBLER__
> >> +#include <linux/io.h>
> >> +#endif
> > You don't need this, do you?
> >
> It can be removed after adding "#include <linux/io.h>" into icoll.c.
fine

> > #inclusion of hardware.h would be OK, then you could remove the
> > #includes of mx23.h and mx28.h in there.
> > (Believe me, this is better, mxc already made me headaches because of
> > that.)
> >
> I do not get it.  Can you please help me understand what you want
> exactly?  Remove includes of mx23.h and mx28.h from hardware.h, and
> then include mx23.h, mx28.h, hardware.h individually when necessary?
Yeap.  You will need hardware.h for mx2[38].h to get the macros
MXS_IO_P2V and IOMEM.

Best regards
UWe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
