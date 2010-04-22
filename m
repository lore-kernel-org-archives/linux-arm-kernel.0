From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 22 Apr 2010 15:40:46 -0400 (EDT)
Subject: Can I use VFP in work queue context ?
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203BABB88B0@dlee02.ent.ti.com>
References: <2A1038AD87AFFA4291065666737B4EAA08CB0BA1BC@dlee06.ent.ti.com>
	<201004221549.26344.siarhei.siamashka@nokia.com>
	<13B9B4C6EF24D648824FF11BE896716203BABB8676@dlee02.ent.ti.com>
	<alpine.LFD.2.00.1004221314530.7232@xanadu.home>
	<13B9B4C6EF24D648824FF11BE896716203BABB88B0@dlee02.ent.ti.com>
Message-ID: <alpine.LFD.2.00.1004221538250.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Apr 2010, Woodruff, Richard wrote:

> 
> > From: Nicolas Pitre [mailto:nico at fluxnic.net]
> > Sent: Thursday, April 22, 2010 12:20 PM
> 
> > > If the work queue executes in a unique context it could follow the
> > > same lazy strategy a user space one does.
> >
> > It could... but that begs the question: what is this that requires so
> > much processing power within the kernel?  This really needs to be fully
> > understood and justified before even considering a possible VFP usage in
> > the kernel.
> 
> A simple candidate is Neon memory copy. It can perform much better 
> than the ARM based one. There are a few unfortunate copies associated 
> with some networking devices which see decent benefit.

The benefit is often lost when you need to defer them to a schedulable 
kernel thread though.


Nicolas
