From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 10 Nov 2014 08:44:43 +0100
Subject: [PATCH] ARM: at91: fix build breakage due to legacy board removals
In-Reply-To: <1415515354-7829-1-git-send-email-olof@lixom.net>
References: <1415515354-7829-1-git-send-email-olof@lixom.net>
Message-ID: <20141110084443.14e76f40@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Sat,  8 Nov 2014 22:42:34 -0800
Olof Johansson <olof@lixom.net> wrote:

> Fixes the following missing includes:
> 
> arch/arm/mach-at91/at91sam9g45.c: In function 'at91sam9g45_init_time':
> arch/arm/mach-at91/at91sam9g45.c:39:23: error: 'NR_IRQS_LEGACY' undeclared (first use in this function)
>   at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
>                        ^
> arch/arm/mach-at91/at91sam9g45.c:39:23: note: each undeclared identifier is reported only once for each function it appears in
> make[3]: *** [arch/arm/mach-at91/at91sam9g45.o] Error 1
> arch/arm/mach-at91/at91sam9rl.c: In function 'at91sam9rl_init_time':
> arch/arm/mach-at91/at91sam9rl.c:51:23: error: 'NR_IRQS_LEGACY' undeclared (first use in this function)
>   at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Sorry I didn't notice this patch and I just sent a fix for the same bug
(with a slightly different approach though):
"ARM: at91: remove useless init_time for DT-only SoCs"

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
