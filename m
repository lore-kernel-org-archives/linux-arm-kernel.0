From: siarhei.siamashka@nokia.com (Siarhei Siamashka)
Date: Thu, 29 Apr 2010 23:38:22 +0300
Subject: Can I use VFP in work queue context ?
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203BABB88B0@dlee02.ent.ti.com>
References: <2A1038AD87AFFA4291065666737B4EAA08CB0BA1BC@dlee06.ent.ti.com>
	<alpine.LFD.2.00.1004221314530.7232@xanadu.home>
	<13B9B4C6EF24D648824FF11BE896716203BABB88B0@dlee02.ent.ti.com>
Message-ID: <201004292338.22971.siarhei.siamashka@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 April 2010 22:33:37 ext Woodruff, Richard wrote:
> > From: Nicolas Pitre [mailto:nico at fluxnic.net]
> > Sent: Thursday, April 22, 2010 12:20 PM
> >
> > > If the work queue executes in a unique context it could follow the
> > > same lazy strategy a user space one does.
> >
> > It could... but that begs the question: what is this that requires so
> > much processing power within the kernel?  This really needs to be fully
> > understood and justified before even considering a possible VFP usage in
> > the kernel.
>
> A simple candidate is Neon memory copy. It can perform much better than the
> ARM based one. There are a few unfortunate copies associated with some
> networking devices which see decent benefit.

Yes, that was my intention from the start.

But after doing some benchmarks, now I suspect that the significant
performance improvement from using NEON instructions is specific to r1pX
Cortex-A8 revision in OMAP34xx/OMAP35xx and newer chips don't gain much.

-- 
Best regards,
Siarhei Siamashka
