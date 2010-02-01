From: rurality.linux@gmail.com (Qiang Wang)
Date: Mon, 1 Feb 2010 17:24:26 +0900
Subject: [PATCH]NUC900 clk enable problem fix
In-Reply-To: <71413c851001220404v14c0ae9bq43c926179ef7c599@mail.gmail.com>
References: <71413c851001220404v14c0ae9bq43c926179ef7c599@mail.gmail.com>
Message-ID: <71413c851002010024p422dfe7dq137bfcf97d6c93fe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello, Dear Wan

please check and ack this patch.
Thank you very much.

best regards
wang qiang

2010/1/22 Qiang Wang <rurality.linux@gmail.com>:
> hello, Wan
>
> ?There is the patch of nuc900 clk enable problem of timers.
> ?I tested it ?in 950 env-board, and shell can come correctly.
>
>
>
> Signed-off-by: Wang Qiang <rurality.linux@gmail.com>
>
> ---
> ?arch/arm/mach-w90x900/cpu.c | ? 10 ++++++++++
> ?1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
> index 20dc0c9..dd8e1fd 100644
> --- a/arch/arm/mach-w90x900/cpu.c
> +++ b/arch/arm/mach-w90x900/cpu.c
> @@ -68,6 +68,11 @@ static DEFINE_CLK(gdma, 27);
> ?static DEFINE_CLK(adc, 28);
> ?static DEFINE_CLK(usi, 29);
> ?static DEFINE_CLK(ext, 0);
> +static DEFINE_CLK(timer0, 19);
> +static DEFINE_CLK(timer1, 20);
> +static DEFINE_CLK(timer2, 21);
> +static DEFINE_CLK(timer3, 22);
> +static DEFINE_CLK(timer4, 23);
>
> ?static struct clk_lookup nuc900_clkregs[] = {
> ? ? ? ?DEF_CLKLOOK(&clk_lcd, "nuc900-lcd", NULL),
> @@ -90,6 +95,11 @@ static struct clk_lookup nuc900_clkregs[] = {
> ? ? ? ?DEF_CLKLOOK(&clk_adc, "nuc900-adc", NULL),
> ? ? ? ?DEF_CLKLOOK(&clk_usi, "nuc900-spi", NULL),
> ? ? ? ?DEF_CLKLOOK(&clk_ext, NULL, "ext"),
> + ? ? ? DEF_CLKLOOK(&clk_timer0, NULL, "timer0"),
> + ? ? ? DEF_CLKLOOK(&clk_timer1, NULL, "timer1"),
> + ? ? ? DEF_CLKLOOK(&clk_timer2, NULL, "timer2"),
> + ? ? ? DEF_CLKLOOK(&clk_timer3, NULL, "timer3"),
> + ? ? ? DEF_CLKLOOK(&clk_timer4, NULL, "timer4"),
> ?};
>
> ?/* Initial serial platform data */
> --
> 1.6.6
>
