From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 22 Jun 2018 09:58:41 +0200
Subject: [PATCH 6/7] ARM: dts: s5pv210: Add initial DTS config for
 SGH-T959P phone
In-Reply-To: <1529608199-5583-7-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1529608199-5583-7-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <CAJKOXPeG89+7PjPfr42posJ9CvhUfFvMNe-oFpi4DiS57-E6cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2018 at 21:09, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>

Commit msg needed.

> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                |  1 +
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 40 +++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 522ebdca1d3d..d00e995875bb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) += \
>         s3c6410-smdk6410.dtb
>  dtb-$(CONFIG_ARCH_S5PV210) += \
>         s5pv210-aquila.dtb \
> +       s5pv210-fascinate4g.dtb \
>         s5pv210-galaxys.dtb \
>         s5pv210-goni.dtb \
>         s5pv210-smdkc110.dtb \
> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> new file mode 100644
> index 000000000000..37967f57c7b7
> --- /dev/null
> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>

Duplicated header.

> +#include "s5pv210-aries.dtsi"
> +
> +/ {
> +       model = "Samsung Galaxy S Fascinate 4G (SGH-T959P) based on S5PV210";
> +       compatible = "samsung,fascinate4g", "samsung,aries", "samsung,s5pv210";
> +
> +       chosen {
> +               bootargs = "console=ttySAC2,115200n8 root=/dev/mmcblk1p1 rw rootwait ignore_loglevel earlyprintk";

Same comment as for Galaxy S.

Best regards,
Krzysztof

> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +
> +               power {
> +                       label = "power";
> +                       gpios = <&gph2 6 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_POWER>;
> +                       wakeup-source;
> +               };
> +
> +               vol-down {
> +                       label = "volume_down";
> +                       gpios = <&gph3 2 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_VOLUMEDOWN>;
> +               };
> +
> +               vol-up {
> +                       label = "volume_up";
> +                       gpios = <&gph3 1 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_VOLUMEUP>;
> +               };
> +       };
> +};
> --
> 2.7.4
>
