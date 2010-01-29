From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jan 2010 19:43:44 +0000
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resume functions
In-Reply-To: <1264792338.1818.28.camel@c-dwalke-linux.qualcomm.com>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
	<1264763312.4242.47.camel@pc1117.cambridge.arm.com>
	<179C5F34D68DF54C8898E904FC5BAF8C79E15B77C4@NALASEXMB09.na.qualcomm.com>
	<1264787969.1818.6.camel@c-dwalke-linux.qualcomm.com>
	<179C5F34D68DF54C8898E904FC5BAF8C79E15B77CD@NALASEXMB09.na.qualcomm.com>
	<1264789772.1818.8.camel@c-dwalke-linux.qualcomm.com>
	<20100129190355.GA19882@n2100.arm.linux.org.uk>
	<1264792338.1818.28.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100129194344.GB19882@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2010 at 11:12:18AM -0800, Daniel Walker wrote:
> On Fri, 2010-01-29 at 19:03 +0000, Russell King - ARM Linux wrote:
> 
> > > 
> > > Maybe cache_sync was recently changed to "writel" instead sync_writel()
> > > due it getting called with the lock already held.
> > 
> > It's pointless discussing what the current code does, because that's
> > not what mainline does _today_ - the locking in this file has
> > completely changed.
> 
> Where is the code we should be looking at (what I quoted is from -next)?

Umm, I think whatever you're looking at is outdated by at least one
month.  What you're trying to tell me is in -next hasn't been there
for at least an entire month:

http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/sfr/linux-next.git;a=blob;f=arch/arm/mm/cache-l2x0.c;h=cb8fc6573b1b2c9dedbeeec0f9a87c491a78ba85;hb=HEAD

This is the same as what was merged into Linus' tree for 2.6.33-rc1
on 17 Dec, and was in -next well before that date.

If your tree has sync_writel() then it's out of date.
