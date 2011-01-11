From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 18:53:06 +0000
Subject: [PATCH] bitops: remove condition code clobber for CLZ
In-Reply-To: <alpine.LFD.2.00.1101111347320.17086@xanadu.home>
References: <1294767725-14814-1-git-send-email-rabin@rab.in>
	<20110111183942.GL11039@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101111347320.17086@xanadu.home>
Message-ID: <20110111185306.GM11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 01:51:19PM -0500, Nicolas Pitre wrote:
> On Tue, 11 Jan 2011, Russell King - ARM Linux wrote:
> 
> > On Tue, Jan 11, 2011 at 11:12:05PM +0530, Rabin Vincent wrote:
> > > The CLZ instruction does not alter the condition flags, so remove the
> > > "cc" clobber from the inline asm for fls().
> > 
> > Do you have any evidence that this changes anything, or is it just
> > subjective?
> 
> This probably doesn't change anything, as gcc has been presuming that 
> inline asms do clobber the condition code for years now, in order to 
> prevent issues caused by a lack of %? appended to instructions in order 
> to conditionally execute them otherwise.  So this would only make the 
> code self consistent.

So given that Linus complains about churn from ARM, what's the
justification to apply a patch which has no effect what so ever?
