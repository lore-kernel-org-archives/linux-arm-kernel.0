From: eric@anholt.net (Eric Anholt)
Date: Thu, 27 Oct 2016 11:20:55 -0700
Subject: [PATCH] irq-bcm2836: Prevent spurious interrupts,
 and trap them early
In-Reply-To: <20161027164051.22493-1-eric@anholt.net>
References: <20161027164051.22493-1-eric@anholt.net>
Message-ID: <87eg31fybc.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> From: Phil Elwell <phil@raspberrypi.org>
>
> The old arch-specific IRQ macros included a dsb to ensure the
> write to clear the mailbox interrupt completed before returning
> from the interrupt. The BCM2836 irqchip driver needs the same
> precaution to avoid spurious interrupts.
>
> Spurious interrupts are still possible for other reasons,
> though, so trap them early.
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> Phil, your patch didn't apply because it looks like you pasted into
> gmail (tabs got converted to spaces).  git-send-email can avoid that.
> I've pulled it out of the rpi tree and applied the s-o-b from your
> email.
>
> Also, patches to lkml need to be sent to the relevant maintainers or
> they won't get picked up.  ./scripts/get_maintainer.pl <patch> can
> give you the list of who to send to/cc.

And then it was my turn to fumble a patch email.  Autocompleted the
wrong version(s).  Resending :(
