From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 11 Jan 2011 13:51:19 -0500 (EST)
Subject: [PATCH] bitops: remove condition code clobber for CLZ
In-Reply-To: <20110111183942.GL11039@n2100.arm.linux.org.uk>
References: <1294767725-14814-1-git-send-email-rabin@rab.in>
	<20110111183942.GL11039@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101111347320.17086@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jan 2011, Russell King - ARM Linux wrote:

> On Tue, Jan 11, 2011 at 11:12:05PM +0530, Rabin Vincent wrote:
> > The CLZ instruction does not alter the condition flags, so remove the
> > "cc" clobber from the inline asm for fls().
> 
> Do you have any evidence that this changes anything, or is it just
> subjective?

This probably doesn't change anything, as gcc has been presuming that 
inline asms do clobber the condition code for years now, in order to 
prevent issues caused by a lack of %? appended to instructions in order 
to conditionally execute them otherwise.  So this would only make the 
code self consistent.


Nicolas
