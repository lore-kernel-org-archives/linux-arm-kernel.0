From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 9 Apr 2014 10:11:15 +0530
Subject: [PATCH RESEND] ARM: spear: add __init to spear_clocksource_init()
In-Reply-To: <1396996485-632-1-git-send-email-elder@linaro.org>
References: <1396996485-632-1-git-send-email-elder@linaro.org>
Message-ID: <CAOh2x=mQF3MLbJwfaBqE3K4Hf-qUrnbHe=6zW0XeK0GEk9raLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 9, 2014 at 4:04 AM, Alex Elder <elder@linaro.org> wrote:
> I get a build warning because spear_clocksource_init() calls
> clocksource_mmio_init(), but it doesn't have an __init annotation.
> Fix that.
>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  arch/arm/mach-spear/time.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index 218ba5b..c4d0931 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -71,7 +71,7 @@ static void clockevent_set_mode(enum clock_event_mode mode,
>  static int clockevent_next_event(unsigned long evt,
>                                  struct clock_event_device *clk_event_dev);
>
> -static void spear_clocksource_init(void)
> +static void __init spear_clocksource_init(void)
>  {
>         u32 tick_rate;
>         u16 val;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
