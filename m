From: ranjithl@ti.com (Ranjith Lohithakshan)
Date: Wed, 20 Jan 2010 19:26:46 +0530
Subject: [PATCH 12/18] OMAP3 clock: split out DPLL3 M2 divider functions
	into clkt3xxx_dpll3m2.c
In-Reply-To: <alpine.DEB.2.00.1001191128120.3977@utopia.booyaka.com>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
	<20100115090703.30690.171.stgit@localhost.localdomain>
	<20100115125014.GK29059@shisha.kicks-ass.net>
	<alpine.DEB.2.00.1001191128120.3977@utopia.booyaka.com>
Message-ID: <4B570B9E.9060104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On Wed, 20-Jan-10 12:06 AM +0530, Paul Walmsley wrote:
> (cc'ing Ranjith)
> 
> Hi Alexander,
> 
> On Fri, 15 Jan 2010, Alexander Shishkin wrote:
> 
>> On Fri, Jan 15, 2010 at 02:07:04 -0700, Paul Walmsley wrote:
>>> Split the DPLL3 M2 divider clock functions out of clock34xx.c and move them
>>> into clkt3xxx_dpll3m2.c to improve maintainability.
>> I'm not very familiar with maintainability issues of dpll3m2, so
>> forgive me if it is ignorant for me to ask you to elaborate on this.
> 
> That is a very good point, those original patch changelogs are pretty 
> crappy.  "OMAP clock code - same great taste, now with more 
> maintainability!"  I will update them and repost with more detail.
> 
>> It does look like a bit of an overkill to have a separate file for
>> a divider. But again, I might well be missing the point.
> 
> Yep, this is definitely a borderline case where it might be more 
> appropriate to keep it in the clock34xx.c file.  What ultimately motivated 
> splitting it out was the thought that the AM3517/3505 chips probably won't 
> need this function, since I don't believe they support DVFS [1], so we 
> could skip compiling this function for kernels built for those devices via 
> the Makefile, and not need #ifdefs. 
> 
> Ranjith, could you correct me if I am wrong about the DVFS part?

You are right, AM35xx devices do not support DVFS. In fact, the only
power management support planned is for the suspend/resume capability
with retention (no off mode)

> 
> 1. AM35x ARM Microprocessor Technical Reference Manual, 
>    http://www.ti.com/litv/pdf/sprugr0

 - Ranjith
