From: hongbo.zhang@linaro.org (Hongbo Zhang)
Date: Wed, 30 Jan 2013 15:56:32 +0800
Subject: [PATCH] ARM: ux500: rename ab8500 to abx500 for hwmon driver
In-Reply-To: <1359531747-3636-1-git-send-email-hongbo.zhang@linaro.org>
References: <1359531747-3636-1-git-send-email-hongbo.zhang@linaro.org>
Message-ID: <CAJLyvQyQWsDYwsEx-t-Jkjp+CKzzBw4woU2ijjAwSSnHkHSZFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus Walleij,
This is for upstreaming AB8500 hwmon, see another Email:
[PATCH] hwmon: add ST-Ericsson ABX500 hwmon driver


On 30 January 2013 15:42, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> We are using a generic abx500 hwmon layer, so rename specific ab8500 to generic
> abx500 for hwmon device and driver matching.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> index e1650ba..579753f 100644
> --- a/drivers/mfd/ab8500-core.c
> +++ b/drivers/mfd/ab8500-core.c
> @@ -922,7 +922,7 @@ static struct resource ab8505_iddet_resources[] = {
>
>  static struct resource ab8500_temp_resources[] = {
>         {
> -               .name  = "AB8500_TEMP_WARM",
> +               .name  = "ABX500_TEMP_WARM",
>                 .start = AB8500_INT_TEMP_WARM,
>                 .end   = AB8500_INT_TEMP_WARM,
>                 .flags = IORESOURCE_IRQ,
> @@ -998,8 +998,8 @@ static struct mfd_cell abx500_common_devs[] = {
>                 .of_compatible = "stericsson,ab8500-denc",
>         },
>         {
> -               .name = "ab8500-temp",
> -               .of_compatible = "stericsson,ab8500-temp",
> +               .name = "abx500-temp",
> +               .of_compatible = "stericsson,abx500-temp",
>                 .num_resources = ARRAY_SIZE(ab8500_temp_resources),
>                 .resources = ab8500_temp_resources,
>         },
> --
> 1.8.0
>
