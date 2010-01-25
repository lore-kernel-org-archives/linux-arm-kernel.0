From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 25 Jan 2010 12:04:13 -0500 (EST)
Subject: [RFC 17/18] arm: mm: Add SW emulation for ARM domain manager
	feature
In-Reply-To: <1264437609.6275.110.camel@pc1117.cambridge.arm.com>
References: <1263250057-26692-18-git-send-email-dwalker@codeaurora.org>
	<1264437609.6275.110.camel@pc1117.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1001251157140.1681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jan 2010, Catalin Marinas wrote:

> Hi Daniel,
> 
> On Mon, 2010-01-11 at 22:47 +0000, Daniel Walker wrote:
> > Do not set domain manager bits in cp15 dacr.  Emulate using SW.  Add
> > kernel hooks to handle domain changes, permission faults, and context
> > switches.
> 
> In case you were not aware, there's a patch around (I think since 2007)
> that removes the domain switching entirely from the kernel (given that
> they have been deprecated for some time and may disappear completely in
> the future):
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005616.html

Also the manager domain doesn't Honor the nx bit, and that is causing 
issues with speculative prefetching as DMA coherent memory area may end 
up being speculatively prefetched unexpectedly.  The on-going DMA 
handling rework takes care of the bigger issue, but the nx bit not being 
observed in all domains is another one for which this patch is a nice 
"fix".


Nicolas
