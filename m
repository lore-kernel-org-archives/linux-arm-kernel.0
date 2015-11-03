From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 3 Nov 2015 17:45:34 +0800
Subject: [PATCH] clocksource: dw_apb_timer_of: support timer-based delay
In-Reply-To: <6198599.NHtefZl19R@wuerfel>
References: <1446193659-1698-1-git-send-email-jszhang@marvell.com>
 <5909853.Bs72yAP0HH@wuerfel>	<20151103145940.18ab648f@xhacker>
 <6198599.NHtefZl19R@wuerfel>
Message-ID: <20151103174534.2c9f5eeb@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd

On Tue, 3 Nov 2015 09:49:32 +0100
Arnd Bergmann wrote:

> On Tuesday 03 November 2015 14:59:40 Jisheng Zhang wrote:
> > > On Monday 02 November 2015 11:03:34 Jisheng Zhang wrote:  
> > > > On Fri, 30 Oct 2015 13:42:01 +0100 Arnd Bergmann wrote:    
> > > I'd be happier with a solution that keeps the DT describing the hardware
> > > and not the way we expect Linux to use it, and instead has some heuristic
> > > in the selection of the delay timer. At the moment, we purely base this
> > > on the frequency, which as you say is suboptimal.
> > > 
> > > One possible way to improve this would be to add an optional 'latency'
> > > property to the DT nodes (or the driver), and use a combination of latency
> > > and resolution to make the decision.  
> > 
> > Got it. Thanks for the suggestions. The 'latency' here seems a 'rating'
> > similar as the one in clocksource. I will cook a series for review:
> > 
> > patch 1 to make register_current_timer_delay() aware of 'rating'
> > 
> > patch 2 to set rating of arch timer as 400
> > 
> > patch 3 to add timer based delay support to dw_apb_timer whose rating is 300  
> 
> Ok. Just to make sure I got this right: your plan is to use the existing
> 'rating' setting as a primary indication, and fall back to comparing the
> frequency if the rating is the same?

Yes, this is my plan.

Thanks,
Jisheng
