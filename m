From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 15 Sep 2014 18:58:52 +0200
Subject: [PATCH 0/2] ARM: at91: Further PIT improvements
In-Reply-To: <1410789744-23975-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1410789744-23975-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54171ACC.1080005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/2014 16:02, Maxime Ripard :
> Hi,
> 
> These patches are meant to address Arnd comments and are based on
> Nicolas' at91-3.18-drivers2 branch.
> 
> They basically just remove the early_platform devices, and keep the
> old mechanism with a function exported by the PIT timer and called by
> the board files.
> 
> Thanks!
> Maxime
> 
> Maxime Ripard (2):
>   ARM: at91: Revert "ARM: at91: PIT: Convert to an
>     early_platform_device"
>   ARM: at91: Give the PIT irq as an argument of at91sam926x_pit_init


Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Ok, I squash these modifications in your previous series and resend a PR
right now.

Thanks, best regards,


>  arch/arm/mach-at91/at91sam9260.c      | 30 ++-------------------------
>  arch/arm/mach-at91/at91sam9261.c      | 30 ++-------------------------
>  arch/arm/mach-at91/at91sam9263.c      | 30 ++-------------------------
>  arch/arm/mach-at91/at91sam9g45.c      | 30 ++-------------------------
>  arch/arm/mach-at91/at91sam9rl.c       | 30 ++-------------------------
>  arch/arm/mach-at91/generic.h          |  2 ++
>  drivers/clocksource/timer-atmel-pit.c | 38 ++++++++++++++---------------------
>  7 files changed, 27 insertions(+), 163 deletions(-)
> 


-- 
Nicolas Ferre
