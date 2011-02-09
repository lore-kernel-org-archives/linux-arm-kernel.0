From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Feb 2011 13:04:59 +0000
Subject: [PATCH] ARM: Correct WFE() in asm/spinlock.h for Thumb-2
In-Reply-To: <001d01cbc842$fa1aacc0$ee500640$@deacon@arm.com>
References: <1297178414-20983-1-git-send-email-dave.martin@linaro.org>
	<20110208164009.GD27521@n2100.arm.linux.org.uk>
	<AANLkTi=XfBjite-xtR8z_+5ATxSb4a9XDNAXdLBowWKY@mail.gmail.com>
	<001d01cbc842$fa1aacc0$ee500640$@deacon@arm.com>
Message-ID: <20110209130459.GB5544@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 09, 2011 at 10:20:29AM -0000, Will Deacon wrote:
> > the WFE into the 4 bytes expected by ALT_SMP().  For safety, I write
> > it out explicitly: ALT_SMP("wfene", ...) would work sometimes but
> > might not work as expected if the previous instruction has an EQ or NE
> > condition, because then the assembler wouldn't need to insert an extra
> > IT when it generates its output...
> 
> That's really horrible! It might be worth commenting the explicit
> IT in your WFE macro to explain why we can't rely on the assembler
> to generate it for us.

Yes, it's really really horrible.  As I say, I think in future I'm just
going to stick to writing good ARM code and let others worry about how
to make it work properly on T2.
