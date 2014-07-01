From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 1 Jul 2014 14:23:44 +0530
Subject: [PATCH] ARM: spear: storage class should be before const qualifier
In-Reply-To: <1404204437-8657-1-git-send-email-tklauser@distanz.ch>
References: <1404204437-8657-1-git-send-email-tklauser@distanz.ch>
Message-ID: <CAOh2x=nZb1gSPd=RCJ8pYE_fWW8Rt-eRnrTBKkkMnEbSKOTHgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 2:17 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> The C99 specification states in section 6.11.5:
>
> The placement of a storage-class specifier other than at the beginning
> of the declaration specifiers in a declaration is an obsolescent
> feature.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  arch/arm/mach-spear/time.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index 26fda4e..a92b1aa 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -193,7 +193,7 @@ static void __init spear_clockevent_init(int irq)
>         setup_irq(irq, &spear_timer_irq);
>  }
>
> -const static struct of_device_id timer_of_match[] __initconst = {
> +static const struct of_device_id timer_of_match[] __initconst = {
>         { .compatible = "st,spear-timer", },
>         { },
>  };

I hope you are using coccinelle to fix these kind of issues, check it
out in case you aren't.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
