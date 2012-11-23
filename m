From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 23 Nov 2012 08:38:52 +0800
Subject: [PATCH] ARM: pxa: pxa25x.c: add dummy SA1100 rtc clock
In-Reply-To: <1353629019-32203-1-git-send-email-andrea.adami@gmail.com>
References: <1353629019-32203-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <CAN1soZwNJRtfqLBqmnCaFt1F5ze2eFDPk8t0+GrjytcHOS-QHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 8:03 AM, Andrea Adami <andrea.adami@gmail.com> wrote:
> * fix failure seen on Zaurus corgi:
> * sa1100-rtc sa1100-rtc: failed to find rtc clock source
> * sa1100-rtc: probe of sa1100-rtc failed with error -2
>
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> ---
>  arch/arm/mach-pxa/pxa25x.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index 3352b37..0f05671 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -209,6 +209,7 @@ static struct clk_lookup pxa25x_clkregs[] = {
>         INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
>         INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
>         INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
> +       INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  };
>
>  static struct clk_lookup pxa25x_hwuart_clkreg =
> --
> 1.7.8.6
>

Acked & Applied
