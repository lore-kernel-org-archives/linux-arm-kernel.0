From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 12:19:53 +0800
Subject: [PATCH] ARM: pxa: hx4700: Initialize DS1WM clock_rate
In-Reply-To: <1334661108.27984.YahooMailClassic@web29018.mail.ird.yahoo.com>
References: <1334661108.27984.YahooMailClassic@web29018.mail.ird.yahoo.com>
Message-ID: <CAN1soZyLC8mXJ5ieiu7Bign24jkRNS0xAq-7nSDi7cZm9u8weg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 7:11 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> The asic3 driver now sets the DS1WM clock_rate from the newly added
> asic3_platform_data clock_rate field.
>
> This patch initializes the asic3_platform_data clock_rate field on the
> hx4700 platform.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> ---
> ?arch/arm/mach-pxa/hx4700.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
> index 00a00a9..6bd692d 100644
> --- a/arch/arm/mach-pxa/hx4700.c
> +++ b/arch/arm/mach-pxa/hx4700.c
> @@ -295,6 +295,7 @@ static struct asic3_platform_data asic3_platform_data = {
> ? ? ? ?.gpio_config_num = ARRAY_SIZE(asic3_gpio_config),
> ? ? ? ?.irq_base ? ? ? ?= IRQ_BOARD_START,
> ? ? ? ?.gpio_base ? ? ? = HX4700_ASIC3_GPIO_BASE,
> + ? ? ? .clock_rate ? ? ?= 4000000,
> ? ? ? ?.leds ? ? ? ? ? ?= asic3_leds,
> ?};
>
> --
> 1.7.3.4
>
Paul,

Could you re-send your patch?

The asic3 driver now sets the DS1WM clock_rate from the newly added=0Aasic3=
_platform_data clock_rate field.=0A=0AThis patch initializes the asic3_plat=
form_data clock_rate field on the=0Ahx4700 platform.=0A=0ASigned-off-by: Pa=
ul Parsons <lost.distance@yahoo.com>=0ACc: Philipp Zabel <philipp.zabel@gma=
il.com>=0A---=0A arch/arm/mach-pxa/hx4700.c |    1 +=0A 1 files changed, 1 =
insertions(+), 0 deletions(-)=0A=0Adiff --git a/arch/arm/mach-pxa/hx4700.c =
b/arch/arm/mach-pxa/hx4700.c=0Aindex 00a00a9..6bd692d 100644=0A--- a/arch/a=
rm/mach-pxa/hx4700.c=0A+++ b/arch/arm/mach-pxa/hx4700.c=0A@@ -295,6 +295,7 =
@@ static struct asic3_platform_data asic3_platform_data =3D {=0A =09.gpio_=
config_num =3D ARRAY_SIZE(asic3_gpio_config),=0A =09.irq_base        =3D IR=
Q_BOARD_START,=0A =09.gpio_base       =3D HX4700_ASIC3_GPIO_BASE,=0A+=09.cl=
ock_rate      =3D 4000000,=0A =09.leds            =3D asic3_leds,=0A };=0A =
=0A-- =0A1.7.3.4=0A

Regards
Haojian
