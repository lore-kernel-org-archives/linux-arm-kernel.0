From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 17 Aug 2010 14:49:05 +0900
Subject: [PATCH 4/5] ARM: S5PC110: Fix GPIO I group config
In-Reply-To: <20100805072550.GA22276@july>
References: <20100805072550.GA22276@july>
Message-ID: <AANLkTi=2Cu5yP0O85MNXDAYQJ9EpHqNiCnerZ5JthCVF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It should be included at rc windows.
It's really bug.

On Thu, Aug 5, 2010 at 4:25 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> GPIO I group doesn't support interrupt feature.
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> ?arch/arm/mach-s5pv210/gpiolib.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
> index bd24c81..94d4fe2 100644
> --- a/arch/arm/mach-s5pv210/gpiolib.c
> +++ b/arch/arm/mach-s5pv210/gpiolib.c
> @@ -159,6 +159,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
> ? ? ? ? ? ? ? ? ? ? ? ?.label ?= "GPG3",
> ? ? ? ? ? ? ? ?},
> ? ? ? ?}, {
> + ? ? ? ? ? ? ? .config = &gpio_cfg_noint,
> ? ? ? ? ? ? ? ?.chip ? = {
> ? ? ? ? ? ? ? ? ? ? ? ?.base ? = S5PV210_GPI(0),
> ? ? ? ? ? ? ? ? ? ? ? ?.ngpio ?= S5PV210_GPIO_I_NR,
> --
> 1.5.3.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
