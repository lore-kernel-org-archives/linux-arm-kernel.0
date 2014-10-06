From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 06 Oct 2014 20:59:28 +0200
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
In-Reply-To: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Mon, 6 Oct 2014 17:32:00 +0400")
References: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <87egulausv.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> This reverts commit 2111667b4677 ("ARM: pxa: call debug_ll_io_init for
> earlyprintk")
>
> This commit gives the following backtrace on PXA/tosa early in the boot
> time when DEBUG_LL is enabled. It is due to overlap between uart memory
> and PERIPH_ memory block mapped by pxa_map_io.

Indeed, all available UARTs IO mappings are already covered by pxa_map_io(), so
the revert will remove the bug and keep the DEBUG_LL functionality. I suppose
you did the test with the revert and the lowlevel debugging works, right ?

Haojian, if you are still taking patches for v3.18-rcs, please have my :
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

If you want me to begin the gathering, tell me.

Cheers.

--
Robert
