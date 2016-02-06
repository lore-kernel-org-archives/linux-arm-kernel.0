From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 06 Feb 2016 22:46:00 +0100
Subject: [PATCH] ARM: pxa: fix irq initialization for pxa3xx devicetree
In-Reply-To: <1454274354-4381-1-git-send-email-robert.jarzmik@free.fr> (Robert
 Jarzmik's message of "Sun, 31 Jan 2016 22:05:54 +0100")
References: <1454274354-4381-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <877fih4inb.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The initialization of interrupt controller for devicetree platform was
> done for pxa2xx platforms, but not for pxa3xx ones.
>
> Fix this my adding the missing initialization call.
>
> Fixes: 089d03629b04 ("ARM: pxa: add devicetree code for irq handling")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
No, this is incorrect.

The reason behind is that it relies on a patch not yet upstreamed, which was
breaking exactly this init_irq.

Let's drop this and replace it with the good patch.

Cheers.

--
Robert
