From: pavel@denx.de (Pavel Machek)
Date: Wed, 18 Sep 2013 12:49:53 +0200
Subject: [RESEND PATCHv3 1/2] clocksource: dw_apb_timer: Move timer
 defines to header file.
In-Reply-To: <alpine.DEB.2.02.1309172359320.4089@ionos.tec.linutronix.de>
References: <1377744796-22175-1-git-send-email-dinguyen@altera.com>
 <1379434447.24347.0.camel@linux-builds1>
 <alpine.DEB.2.02.1309172337570.4089@ionos.tec.linutronix.de>
 <20130917215544.GB23937@amd.pavel.ucw.cz>
 <alpine.DEB.2.02.1309172359320.4089@ionos.tec.linutronix.de>
Message-ID: <20130918104953.GA31735@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > > From: Dinh Nguyen <dinguyen@altera.com>
> > > > > 
> > > > > Move all dw_apb_timer defines to include/linux/dw_apb_timer.h.
> > > 
> > > That's describing WHAT the patch does not WHY. I can see the WHAT part
> > > without that pointless changelog.
> > 
> > read_sched_clock() in dw_apb_timer_of.c accesses the same hardware as
> > dw_apb_timer.c, therefore it benefits from #define's that describe the
> > hardware. IOW 1/2 is neccessary for 2/2, but it can compile/work
> > indepedently.
> 
> I'm really capable of figuring that out myself. But that's not the
> point. I want patch submitters to explain in the changelog WHY they
> are doing a change not WHAT they are doing, because that's (mostly)
> obvious from the patch itself.

But the end result is that anything takes months to do...

We already have the dw_apb_timer issues merged in your tree, then it
got dropped in merge conflict, then you dislike the changelog, and now
you notice devicetree uglyness that we did not introduce.

Yes, dw_apb_timer code is not exactly clean, but if we have to wait
month before you lecture us how to write changelogs, we will not get
anywhere... discussion why the DT was done that way is forgotten by
now.

Because just now, we are running in circles (and time does not work on
socfpga for second major release).

Regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
