From: rabin@rab.in (Rabin Vincent)
Date: Mon, 7 Feb 2011 11:18:50 +0530
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <-2131964397930844736@unknownmsgid>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
	<-2131964397930844736@unknownmsgid>
Message-ID: <AANLkTimYwi4P=nGTQsibvxe9e1weYS9TLCCUg2BidbRx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 17:09, Will Deacon <will.deacon@arm.com> wrote:
> Ah yes, I have some hazy memories of this conversation! I think you
> have three options:

Here's the implementation of a different approach which bounces the
IRQ to the other CPU by setting the affinity when the current CPU
would return IRQ_NONE.

It has the advantage over the IPI method that Core0 does not need
to spin (in the interrupt handler) waiting for Core1 to handle
the IPI:

(patch attached as well, since it will probably be mangled)

8<------------
