From: rabin@rab.in (Rabin Vincent)
Date: Mon, 22 Feb 2010 23:36:24 +0530
Subject: [PATCH 02/10] ARM: ftrace: document mcount formats
In-Reply-To: <20100213203748.GC16528@pengutronix.de>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-3-git-send-email-rabin@rab.in>
	<20100213203748.GC16528@pengutronix.de>
Message-ID: <20100222180624.GA4061@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 13, 2010 at 09:37:48PM +0100, Uwe Kleine-K?nig wrote:
> On Sun, Feb 14, 2010 at 01:18:30AM +0530, Rabin Vincent wrote:
> > + * With both the mcount types, we need to restore the original lr before
> > + * returning.  In the __gnu_mcount_nc, version we're allowed to clobber ip.
> > + * No other registers should be clobbered.
> > + */
> Very nice.
> 
> Maybe make the last two sentences:
> 
> In the __gnu_mcount_nc case the ip register is clobbered which is OK as
> the calling convention for ARM allow clobbering this value for
> subroutines and it doesn't contain parameters.

Won't quoting calling conventions here be misleading?  The mcounts don't
following normal convention for the other bits (we can't clobber even
the registers that are normally caller-saved, we need to restore lr,
etc.)

Rabin
