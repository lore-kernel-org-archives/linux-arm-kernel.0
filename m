From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Apr 2017 16:52:42 +0200
Subject: [PATCH 5/7] regulator: arizona-ldo1: Move pdata into a separate
 structure
In-Reply-To: <1492512234-19210-7-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1492512234-19210-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1492512234-19210-7-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <CAJKOXPd81C9FOtXVcpwAd=-rWNS0jQK+Qt8NqokmppP8HUKLCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 12:43 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:
> In preparation for sharing this driver with Madera, move the pdata
> for the LDO1 regulator out of struct arizona_pdata into a dedicated
> pdata struct for this driver. As a result the code in
> arizona_ldo1_of_get_pdata() can be made independent of struct arizona.
>
> This patch also updates the definition of struct arizona_pdata and
> the use of this pdata in mach-crag6410-module.c
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c |  8 ++++--
>  drivers/regulator/arizona-ldo1.c             | 39 +++++++++++++++-------------
>  include/linux/mfd/arizona/pdata.h            |  4 +--
>  include/linux/regulator/arizona-ldo1.h       | 24 +++++++++++++++++
>  4 files changed, 53 insertions(+), 22 deletions(-)
>  create mode 100644 include/linux/regulator/arizona-ldo1.h
>
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> index ccc3ab8..ea5f216 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -209,7 +209,9 @@
>  };
>
>  static struct arizona_pdata wm5102_reva_pdata = {
> -       .ldoena = S3C64XX_GPN(7),
> +       .ldo1 = {
> +               .ldoena = S3C64XX_GPN(7),
> +       },
>         .gpio_base = CODEC_GPIO_BASE,
>         .irq_flags = IRQF_TRIGGER_HIGH,
>         .micd_pol_gpio = CODEC_GPIO_BASE + 4,
> @@ -239,7 +241,9 @@
>  };
>
>  static struct arizona_pdata wm5102_pdata = {
> -       .ldoena = S3C64XX_GPN(7),
> +       .ldo1 = {
> +               .ldoena = S3C64XX_GPN(7),
> +       },
>         .gpio_base = CODEC_GPIO_BASE,
>         .irq_flags = IRQF_TRIGGER_HIGH,
>         .micd_pol_gpio = CODEC_GPIO_BASE + 2,

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
