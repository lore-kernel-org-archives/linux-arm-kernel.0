From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 Jan 2013 10:14:24 -0800
Subject: [PATCH] ARM: at91: fix board-rm9200-dt after sys_timer conversion
In-Reply-To: <1358185342-7518-1-git-send-email-swarren@wwwdotorg.org>
References: <1358185342-7518-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130114181424.GA31901@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 10:42:22AM -0700, Stephen Warren wrote:
> From: Joachim Eastwood <manabian@gmail.com>
> 
> After "ARM: delete struct sys_timer" board-rm9200-dt
> fails compilation with the following error:
> 
>   CC      arch/arm/mach-at91/board-rm9200-dt.o
> arch/arm/mach-at91/board-rm9200-dt.c:50:2: error: unknown field 'timer' specified in initializer
> arch/arm/mach-at91/board-rm9200-dt.c:50:13: error: 'at91rm9200_timer' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-at91/board-rm9200-dt.o] Error 1
> make: *** [arch/arm/mach-at91] Error 2
> 
> This is a fall out from the timer conversion. Fix it by
> converting board-rm9200-dt to use new timer init
> function as well.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Olof, Arnd, another fix for the timer-cleanup branch in arm-soc.

Applied to timer/cleanup. Thanks!


-Olof
