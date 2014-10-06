From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Oct 2014 23:18:43 +0200
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
In-Reply-To: <20141006210209.GA21019@og3k>
References: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
 <87a959aten.fsf@free.fr> <20141006210209.GA21019@og3k>
Message-ID: <6310030.SmNYckCtJ4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 October 2014 16:02:09 Andrew Ruder wrote:
> On Mon, Oct 06, 2014 at 09:29:36PM +0200, Robert Jarzmik wrote:
> > Actually, I have a question for Andrew : was your commit aimed at the 3 or 4
> > available UARTs (ie. in peripheral address space), or is it a case where an
> > external UART is mapped on the system bus (if that is possible) ?
> 
> My apologies!  I'm actually on a really long-term project of getting my
> board (similar to zeus board already in the kernel) fully running off of
> devicetree.  For this particular board, all of the UARTS are on the
> system bus and not the built in ones.  But yes - I do see how the
> built-in UARTS would overlap and hit the BUG_ON on other boards.  Any
> thoughts on a better way of solving this than just reverting the patch
> back into only working on the built-in UARTs?

I think the best way forward is to make the built-in UARTs work with
debug_ll_io_init and then apply your patch again.

On a more general note, my personal opinion is that in case of PXA,
we should not (yet) block additional board files because of missing DT
support. I think it's still a long way before it will work, and most
of the work is done by hobbyists, so I would allow new board files for
PXA to be added. Of course if the PXA maintainers think differently,
they can still ask you do to a DT port.

	Arnd
