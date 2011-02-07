From: rabin@rab.in (Rabin Vincent)
Date: Mon, 7 Feb 2011 11:26:09 +0530
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <-2131964397930844736@unknownmsgid>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
	<-2131964397930844736@unknownmsgid>
Message-ID: <AANLkTi=atjR8-gDU-9=3o5GLjj+S50-7k_myP199tp0G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 17:09, Will Deacon <will.deacon@arm.com> wrote:
> 2.) Use IPI to cross-call the IRQ handler when the interrupted CPU doesn't
> ? ?have an interrupt asserted on its PMU. You'll need to sort out problems
> ? ?with re-enabling interrupts for the cross-call and also nesting of the
> ? ?PMU interrupt (because it could fire as a result of another PMU overflowing
> ? ?before you've completed the cross-call).

Here's the IPI version as well, for comparison with the other
approach.  The IRQ handling code will mask the interrupt before
handling it, so it can't nest, can it?

8<----------
