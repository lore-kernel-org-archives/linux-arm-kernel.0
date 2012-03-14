From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 14 Mar 2012 22:53:44 +0100
Subject: [PATCH v3 1/5] ARM: protect usage of cr_alignment by #ifdef
 CONFIG_CPU_CP15
In-Reply-To: <alpine.LFD.2.02.1203141710210.24151@xanadu.home>
References: <20120314101928.GA29474@pengutronix.de>
 <1331720483-10075-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <alpine.LFD.2.02.1203141103080.24151@xanadu.home>
 <20120314195120.GA2391@pengutronix.de>
 <alpine.LFD.2.02.1203141710210.24151@xanadu.home>
Message-ID: <20120314215344.GD2391@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,

On Wed, Mar 14, 2012 at 05:19:53PM -0400, Nicolas Pitre wrote:
> On Wed, 14 Mar 2012, Uwe Kleine-K?nig wrote:
> > On Wed, Mar 14, 2012 at 11:24:36AM -0400, Nicolas Pitre wrote:
> > > >  	flush_cache_all();
> > > > +#ifdef CONFIG_CPU_CP15
> > > >  	set_cr(cr_alignment);
> > > > +#endif
> > > 
> > > However it might be best to provide a dummy set_cr() instead of 
> > > #ifdef'ing it out everywhere.
> > What should the dummy set_cr do? Print a runtime warning if called with
> > != 0?
> 
> Maybe not.  In fact if that code path is used, then something might be 
> wrong at a higher level.
And that's why I choosed not to implement a dummy set_cr ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
