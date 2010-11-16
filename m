From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Nov 2010 10:11:57 -0800
Subject: [PATCH] omap4: enable L2 prefetching
In-Reply-To: <yw1xaala8qex.fsf@unicorn.mansr.com>
References: <1289838044-32016-1-git-send-email-nm@ti.com>
	<yw1xaala8qex.fsf@unicorn.mansr.com>
Message-ID: <20101116181157.GY9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* M?ns Rullg?rd <mans@mansr.com> [101115 09:01]:
> Nishanth Menon <nm@ti.com> writes:
> 
> > From: Mans Rullgard <mans@mansr.com>
> >
> > Enabling L2 prefetching improves performance as shown on Panda
> > ES2.1 board with mem test, and it has measurable impact on
> > performances. I think we should consider it, even though it damages
> > "writes" a bit. (rebased to k.org)
> > Usually the prefetch is used at both levels together L1 + L2, however,
> > to enable the CP15 prefetch engines, these are under security, and on
> > GP devices, we cannot enable it(e.g. on PandaBoard). However, just
> > enabling PL310 prefetch seems to provide performance improvement,
> > as shown in the data below (from Ubuntu) and would be a great thing
> > to pull in.
> 
> What this does is enable automatic next line prefetching.  With this
> enabled, whenever the PL310 receives a cachable read request, it
> automatically prefetches the following cache line as well.  A larger
> offset can be programmed in secure mode, but the TI ROM authors
> neglected to include this.
> 
> Testing with FFmpeg showed a speedup of 10% with this patch in some
> cases.

M?ns and Nishant, care to repost this with the updated comments?

Regards,

Tony
