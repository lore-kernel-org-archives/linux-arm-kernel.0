From: andy@aeruder.net (Andrew Ruder)
Date: Mon, 6 Oct 2014 16:55:47 -0500
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
In-Reply-To: <6310030.SmNYckCtJ4@wuerfel>
References: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
 <87a959aten.fsf@free.fr> <20141006210209.GA21019@og3k>
 <6310030.SmNYckCtJ4@wuerfel>
Message-ID: <20141006215547.GB21019@og3k>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 11:18:43PM +0200, Arnd Bergmann wrote:
> I think the best way forward is to make the built-in UARTs work with
> debug_ll_io_init and then apply your patch again.

Agreed, when I get some time I'll take a look at this again.  I now have
another PXA based board using built-in UARTs for the debug console so
I can test a little more thoroughly.  So for now:

Acked: Andrew Ruder <andrew.ruder@elecsyscorp.com>

on the revert.  Sorry again for the churn - dropped the ball on this
one.

> On a more general note, my personal opinion is that in case of PXA,
> we should not (yet) block additional board files because of missing DT
> support. I think it's still a long way before it will work, and most
> of the work is done by hobbyists, so I would allow new board files for
> PXA to be added. Of course if the PXA maintainers think differently,
> they can still ask you do to a DT port.

I'm more of the opinion that we aren't that far from being able to block
board files - I am 100% using device-tree and now have a single kernel
that will boot on 3 different Elecsys boards.  Not to mention the fact
that I can't imagine there's a whole lot of new hardware work in the PXA
realm.

I have posted the work to my github account
(http://github.com/aeruder/linux) but it is tough work getting things
cleaned up to not break anyone not using DT (HAH, see this thread),
documented, and submitted.  I was really hoping the big mmc/DMA rewrite
would drop into mainline at some point since that is one of the more
terrible hacks I'm still maintaining over here.

Cheers,
Andy
