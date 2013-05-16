From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 May 2013 11:15:16 -0500
Subject: [PATCH 2/4] ARM: highbank: remove the .map_io declaration
In-Reply-To: <1368440169-29088-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1368440169-29088-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368440169-29088-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAL_Jsq+R_3K4PyYsvq4qo11wEmQkHB2Q+dZm68jqcKn9rDmqLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 5:16 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Now that the ARM core code calls debug_ll_io_init, we can remove it from
> the machine_desc declaration.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  arch/arm/mach-highbank/highbank.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index e7df2dd..dc5d6be 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -176,7 +176,6 @@ static const char *highbank_match[] __initconst = {
>
>  DT_MACHINE_START(HIGHBANK, "Highbank")
>         .smp            = smp_ops(highbank_smp_ops),
> -       .map_io         = debug_ll_io_init,
>         .init_irq       = highbank_init_irq,
>         .init_time      = highbank_timer_init,
>         .init_machine   = highbank_init,
> --
> 1.8.1.2
>
