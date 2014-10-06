From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 06 Oct 2014 21:29:36 +0200
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
In-Reply-To: <87egulausv.fsf@free.fr> (Robert Jarzmik's message of "Mon, 06
 Oct 2014 20:59:28 +0200")
References: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
 <87egulausv.fsf@free.fr>
Message-ID: <87a959aten.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>
>> This reverts commit 2111667b4677 ("ARM: pxa: call debug_ll_io_init for
>> earlyprintk")
>>
>> This commit gives the following backtrace on PXA/tosa early in the boot
>> time when DEBUG_LL is enabled. It is due to overlap between uart memory
>> and PERIPH_ memory block mapped by pxa_map_io.
>
> Indeed, all available UARTs IO mappings are already covered by pxa_map_io(), so
> the revert will remove the bug and keep the DEBUG_LL functionality. I suppose
> you did the test with the revert and the lowlevel debugging works, right ?

Actually, I have a question for Andrew : was your commit aimed at the 3 or 4
available UARTs (ie. in peripheral address space), or is it a case where an
external UART is mapped on the system bus (if that is possible) ?

-- 
Robert
