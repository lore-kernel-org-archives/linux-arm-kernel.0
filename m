From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Mar 2011 21:57:08 +0530
Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for GPT1
In-Reply-To: <alpine.DEB.2.00.1103100744500.15132@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
	<alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com>
	<3b8b985f13158fbcd110cf45ed7035ad@mail.gmail.com>
	<alpine.DEB.2.00.1103100744500.15132@utopia.booyaka.com>
Message-ID: <9c47364db2da7c8bcec3e21463f001fe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Thursday, March 10, 2011 8:15 PM
> To: Santosh Shilimkar
> Cc: Benoit Cousson; Rajendra Nayak; linux-omap at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; Kevin Hilman
> Subject: RE: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle
> for GPT1
>
> On Thu, 10 Mar 2011, Santosh Shilimkar wrote:
>
> > We continued further debug on the static dependency issues with
> > OMAP4 PM series.
> > So far from the findings what I have, this timer patch is actually
> not
> > needed and can be dropped. Infact the patch is not really
> effective
> > because current timer driver(not hwmod adapted yet) puts timer1
> > in smart idle again.
> >
> > There is another static dep. just like MPUSS<-->EMIF seems to
> create
> > an issue. The lock-up is not very consistently reproducible so
> it's
> > very easy to get miss-leading results. Timer patch was one of
> those
> > observations. With or without timer patch I can reproduce the hang
> > with long duration test.
> >
> > Will keep narrowing down the next offending static dependency but
> > in mean time I suggest you to drop this patch.
>
> Okay, dropped.
>
Managed to narrow down the issue with below two offender.
1) MPUSS <--> MEMIF_STATDEP
2) MPUSS <--> L3_1_STATDEP

If we keep both of these static deps, then I don't see any
issues. Will give a overnight run to check the stability.

Will update the below patch to include L3_1 CD and
repost the same.
https://patchwork.kernel.org/patch/620351/

Regards
Santosh
