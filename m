From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 15 Jan 2015 14:23:00 +0100
Subject: [PATCH RESEND] pxa_timer: fix session missmatch warning
In-Reply-To: <1421286860-23296-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Thu, 15 Jan 2015 04:54:20 +0300")
References: <1421286860-23296-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <87h9vsxjnv.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Fix the following warning:
>
> WARNING: drivers/clocksource/built-in.o(.text.unlikely+0x70): Section mismatch in reference from the function pxa_timer_common_init() to the function .init.text:clocksource_mmio_init()
> The function pxa_timer_common_init() references
> the function __init clocksource_mmio_init().
> This is often because pxa_timer_common_init lacks a __init
> annotation or the annotation of clocksource_mmio_init is wrong.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

On a side note, I never get this warning in my builds, either on linux-next or
linus tree, probably because pxa_timer_common_init() is always inlined in my
builds.

Cheers.

--
Robert
