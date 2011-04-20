From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Apr 2011 14:36:07 +0200
Subject: [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries for
	some global variables
In-Reply-To: <alpine.LFD.2.00.1104200826550.24613@xanadu.home>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
	<20110420084234.GV31131@pengutronix.de>
	<alpine.LFD.2.00.1104200826550.24613@xanadu.home>
Message-ID: <20110420123607.GX31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Apr 20, 2011 at 08:28:20AM -0400, Nicolas Pitre wrote:
> On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> > On Wed, Apr 20, 2011 at 12:15:04AM -0400, Nicolas Pitre wrote:
> > > +#define static /* non-static */
> > >  #include <mach/uncompress.h>
> > > +#undef static
> > This has a strange side effect, i.e. 
> > 
> > 	static something *ptr;
> > 
> > isn't initialised to NULL anymore IIRC. So the maintainers of
> > the various mach/uncompress.h still need to be aware of the issue.
> 
> Please tell me more about your setup.  This should still be initialized 
> to NULL.  If not then something else is still wrong.
I didn't test your branch. If you say that non-static data is
zero-initialised, too, I believe you without further checking.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
