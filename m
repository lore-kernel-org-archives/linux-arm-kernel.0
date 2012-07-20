From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 20 Jul 2012 11:37:06 +0300
Subject: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
 suspend
In-Reply-To: <alpine.DEB.2.00.1207191726090.14390@utopia.booyaka.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
 <1342704392-23657-8-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com>
 <1342711907.4672.153.camel@sokoban>
 <alpine.DEB.2.00.1207191726090.14390@utopia.booyaka.com>
Message-ID: <1342773426.4672.173.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-19 at 17:30 -0600, Paul Walmsley wrote:
> Hi
> 
> On Thu, 19 Jul 2012, Tero Kristo wrote:
> 
> > Subject: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
> > suspend
> > 
> > Currently OMAP4 suspend puts all power domains to CSWR. OSWR is a deeper
> > state that saves more power, but has higher latencies also. As suspend
> > is considered a high-latency operation, OSWR is appropriate here.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> > 
> > I'll update this to next rev if one is requested.
> 
> No need, I'll add it in the local copy here.

Thanks, thats what I thought. :)

> 
> > (Kind of hoping this set would be reaching maturity already.)
> 
> It kind of looks to me like there are two or three separate sets within 
> the series.  My feeling is that Kevin should take the first two, then I 
> should take the rest other than 6 and 7.  Then once those are queued, 
> we can pull in 6 and 7.  Does that make sense to you?

Yea, that looks good to me. Patches up from 6+ should only be pulled
once the pre-reqs for this set are in also (io-chain + Jean's func pwrst
stuff.) I haven't actually tried these patches without the pre-reqs
lately, but I think they should be fine.

-Tero
