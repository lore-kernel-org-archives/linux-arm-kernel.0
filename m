From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Oct 2014 21:30:22 +0200
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
In-Reply-To: <87egulausv.fsf@free.fr>
References: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
 <87egulausv.fsf@free.fr>
Message-ID: <1863148.6Gay0UyraW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 October 2014 20:59:28 Robert Jarzmik wrote:
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
> 
> > This reverts commit 2111667b4677 ("ARM: pxa: call debug_ll_io_init for
> > earlyprintk")
> >
> > This commit gives the following backtrace on PXA/tosa early in the boot
> > time when DEBUG_LL is enabled. It is due to overlap between uart memory
> > and PERIPH_ memory block mapped by pxa_map_io.
> 
> Indeed, all available UARTs IO mappings are already covered by pxa_map_io(), so
> the revert will remove the bug and keep the DEBUG_LL functionality. I suppose
> you did the test with the revert and the lowlevel debugging works, right ?
> 
> Haojian, if you are still taking patches for v3.18-rcs, please have my :
> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

This is a regression fix, so it should go into 3.18 and 3.17-stable once
everybody agrees that it is the correct solution.

	Arnd
