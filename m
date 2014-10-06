From: andrew.ruder@elecsyscorp.com (Andrew Ruder)
Date: Mon, 6 Oct 2014 16:02:09 -0500
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
In-Reply-To: <87a959aten.fsf@free.fr>
References: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
 <87egulausv.fsf@free.fr> <87a959aten.fsf@free.fr>
Message-ID: <20141006210209.GA21019@og3k>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 09:29:36PM +0200, Robert Jarzmik wrote:
> Actually, I have a question for Andrew : was your commit aimed at the 3 or 4
> available UARTs (ie. in peripheral address space), or is it a case where an
> external UART is mapped on the system bus (if that is possible) ?

My apologies!  I'm actually on a really long-term project of getting my
board (similar to zeus board already in the kernel) fully running off of
devicetree.  For this particular board, all of the UARTS are on the
system bus and not the built in ones.  But yes - I do see how the
built-in UARTS would overlap and hit the BUG_ON on other boards.  Any
thoughts on a better way of solving this than just reverting the patch
back into only working on the built-in UARTs?

Thanks,
Andrew Ruder
