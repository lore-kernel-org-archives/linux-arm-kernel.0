From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 14:22:20 +0000
Subject: [PATCH] bitops: remove condition code clobber for CLZ
In-Reply-To: <AANLkTimyjEvKVusSvmdpgcMT=WeP3WwYDDYcWO8XKiY2@mail.gmail.com>
References: <1294767725-14814-1-git-send-email-rabin@rab.in>
	<20110111183942.GL11039@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101111347320.17086@xanadu.home>
	<AANLkTimyjEvKVusSvmdpgcMT=WeP3WwYDDYcWO8XKiY2@mail.gmail.com>
Message-ID: <20110112142220.GA11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 07:48:10PM +0530, Rabin Vincent wrote:
> On Wed, Jan 12, 2011 at 00:21, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 11 Jan 2011, Russell King - ARM Linux wrote:
> >> On Tue, Jan 11, 2011 at 11:12:05PM +0530, Rabin Vincent wrote:
> >> > The CLZ instruction does not alter the condition flags, so remove the
> >> > "cc" clobber from the inline asm for fls().
> >>
> >> Do you have any evidence that this changes anything, or is it just
> >> subjective?
> >
> > This probably doesn't change anything, as gcc has been presuming that
> > inline asms do clobber the condition code for years now, in order to
> > prevent issues caused by a lack of %? appended to instructions in order
> > to conditionally execute them otherwise.
> 
> FWIW, note that I am able to see GCC using the condition code clobber
> information.  For example, for this (artificial) test code:

Ok, better code generation is a reason to apply this patch (not that
the example particularly shows that the new order was better - but it
can potentially be if there's loads around.)
