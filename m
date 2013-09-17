From: pavel@denx.de (Pavel Machek)
Date: Tue, 17 Sep 2013 23:55:44 +0200
Subject: [RESEND PATCHv3 1/2] clocksource: dw_apb_timer: Move timer
 defines to header file.
In-Reply-To: <alpine.DEB.2.02.1309172337570.4089@ionos.tec.linutronix.de>
References: <1377744796-22175-1-git-send-email-dinguyen@altera.com>
 <1379434447.24347.0.camel@linux-builds1>
 <alpine.DEB.2.02.1309172337570.4089@ionos.tec.linutronix.de>
Message-ID: <20130917215544.GB23937@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2013-09-17 23:45:11, Thomas Gleixner wrote:
> On Tue, 17 Sep 2013, Dinh Nguyen wrote:
> 
> > On Wed, 2013-08-28 at 21:53 -0500, Dinh Nguyen wrote:
> > > From: Dinh Nguyen <dinguyen@altera.com>
> > > 
> > > Move all dw_apb_timer defines to include/linux/dw_apb_timer.h.
> 
> That's describing WHAT the patch does not WHY. I can see the WHAT part
> without that pointless changelog.

read_sched_clock() in dw_apb_timer_of.c accesses the same hardware as
dw_apb_timer.c, therefore it benefits from #define's that describe the
hardware. IOW 1/2 is neccessary for 2/2, but it can compile/work
indepedently.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
