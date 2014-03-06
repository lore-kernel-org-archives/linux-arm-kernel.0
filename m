From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 6 Mar 2014 10:19:50 +0800
Subject: [PATCH 1/4] ARM: spear: storage class should be before const
 qualifier
In-Reply-To: <1394037216-1630-1-git-send-email-tklauser@distanz.ch>
References: <1394037216-1630-1-git-send-email-tklauser@distanz.ch>
Message-ID: <CAOh2x=m3anFNfNDKsdZ1fAD472qcRVqLoAzZw=LZ+xg=8tw8zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 6, 2014 at 12:33 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
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
> index d449673..1963f17 100644
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
