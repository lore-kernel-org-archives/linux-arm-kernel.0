From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 08 Oct 2016 11:27:54 +0200
Subject: [PATCH] ARM: pxa: pxa_cplds: honor probe deferral
In-Reply-To: <1474874488-26533-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Mon, 26 Sep 2016 09:21:28 +0200")
References: <1474874488-26533-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87d1jb8a1x.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The method to acquire the input interrupt was working in a platform data
> based board, but was failing in a device-tree one when the gpio
> controller was probed after pxa_cplds.
>
> Use platform_get_irq() to benefit from the probe deferral
> mechanism. Moreover, as seen in dm9000.c development, platform_get_irq()
> doesn't honor the irq type IO resource (ie. edge rising for example),
> and it must be passed again at irq request in a not device-tree build,
> hence the irq_get_trigger_type() call.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Applied to pxa/for-next.

Cheers.

--
Robert
