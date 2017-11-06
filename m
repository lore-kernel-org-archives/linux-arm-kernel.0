From: keescook@chromium.org (Kees Cook)
Date: Mon, 6 Nov 2017 12:47:25 -0800
Subject: [PATCH] [fixup timers-conversion] ARM: footbridge: add missing
 semicolon
In-Reply-To: <20171106133410.467203-1-arnd@arndb.de>
References: <20171106133410.467203-1-arnd@arndb.de>
Message-ID: <CAGXu5jLC7rEpvh_XG1B3zVoGh6b35sG=DJd49dim5JY74HSEmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks! I noticed the report just before I saw your email. :) This
should be fixed in tip soon.

-Kees

On Mon, Nov 6, 2017 at 5:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The timer_setup() conversion included a small typo that breaks the
> build:
>
> arch/arm/mach-footbridge/dc21285.c: In function 'dc21285_enable_error':
> arch/arm/mach-footbridge/dc21285.c:145:2: error: expected ';' before 'else'
>   else if (timer == &perr_timer)
>
> Fixes: b7bea32f0cc4 ("ARM: footbridge: Convert timers to use timer_setup()")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The broken patch is currently in -tip and came in through timers-conversion-next3.
> Please apply this one on top, or fold it into the original patch if possible
> ---
>  arch/arm/mach-footbridge/dc21285.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
> index 8407e4a07c77..e7b350f18f5f 100644
> --- a/arch/arm/mach-footbridge/dc21285.c
> +++ b/arch/arm/mach-footbridge/dc21285.c
> @@ -141,7 +141,7 @@ static void dc21285_enable_error(struct timer_list *timer)
>         del_timer(timer);
>
>         if (timer == &serr_timer)
> -               enable_irq(IRQ_PCI_SERR)
> +               enable_irq(IRQ_PCI_SERR);
>         else if (timer == &perr_timer)
>                 enable_irq(IRQ_PCI_PERR);
>  }
> --
> 2.9.0
>



-- 
Kees Cook
Pixel Security
