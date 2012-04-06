From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 06 Apr 2012 21:45:06 +0400
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include
In-Reply-To: <1333717838.12209.83.camel@dagon.hellion.org.uk>
References: <1333715458-13834-1-git-send-email-ijc@hellion.org.uk>
 <4F7EE6AE.4020909@mvista.com>
 <1333717838.12209.83.camel@dagon.hellion.org.uk>
Message-ID: <4F7F2BA2.9040308@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2012 05:10 PM, Ian Campbell wrote:

>>> Fixes build the following error when CONFIG_KEXEC is enabled:

>>      Maybe "the following build error" instead?

> Done.

   Not quite. Still "fixes build the following...". :-)

>>>     CC      arch/arm/mach-kirkwood/board-dt.o
>>> arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
>>> arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
>>> arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in

>>> kexec.h also needs string.h.

>>      Why it doesn't include it?

> Not sure, but actually I should be using linux/kexec.h not asm/kexec.h
> anyway which solves the problem too:

> 8<------------------------------

>  From 76ef56286c1ceeceaa4c6c5ba867d9504e175382 Mon Sep 17 00:00:00 2001
> From: Ian Campbell<ijc@hellion.org.uk>
> Date: Fri, 6 Apr 2012 13:27:23 +0100
> Subject: [PATCH] ARM: kirkwood: add missing kexec.h include

> Fixes build the following build error when CONFIG_KEXEC is enabled:

    What I meant was "Fixes the following build error when CONFIG_KEXEC is 
enabled:".

>    CC      arch/arm/mach-kirkwood/board-dt.o
> arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
> arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
> arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in

> Signed-off-by: Ian Campbell<ijc@hellion.org.uk>
> [v2, using linux/kexec.h not asm/kexec.h]

WBR, Sergei
