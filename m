From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 28 Jan 2017 15:25:02 +0100
Subject: [PATCH] ARM: BCM5301X: Add missing Netgear R8000 LEDs and Keys
In-Reply-To: <20170128134345.5465-1-adityaxavier@gmail.com>
References: <20170128134345.5465-1-adityaxavier@gmail.com>
Message-ID: <CACna6rwSs20asivXUsLQtmTtxppnpV4On1Kr8yNBdVYAH_csjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nice work, you're almost there!

Since quite recently ARM DTS patches have to use extra "dts: " prefix,
I understand you could miss that. Please just change your subject from
ARM: BCM5301X: Add missing Netgear R8000 LEDs and Keys
to
ARM: dts: BCM5301X: Add missing Netgear R8000 LEDs and Keys
and it'll be great.

When bumping patch version it's also nice to include version number in
the tag, e.g.
[PATCH V2]
You can achieve this by e.g.
git format-patch --subject-prefix="PATCH V2" -1


On 28 January 2017 at 14:43, AdityaXavier <adityaxavier@gmail.com> wrote:
> From: Aditya Xavier <adityaxavier@gmail.com>
>
> Added two WAN status LEDs and a GPIO Key for Brightness which were missing.
>
> Signed-off-by: Aditya Xavier <adityaxavier@gmail.com>
> ---

Ideally, in this place should go a changelog. E.g.:
V2: Update subject and change LED names


>  arch/arm/boot/dts/bcm4709-netgear-r8000.dts | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> index 92f8a72..90d4420 100644
> --- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> +++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
> @@ -27,18 +27,30 @@
>         leds {
>                 compatible = "gpio-leds";
>
> -               power0 {
> +               power-white {
>                         label = "bcm53xx:white:power";
>                         gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
>                         linux,default-trigger = "default-on";
>                 };
>
> -               power1 {
> +               power-amber {
>                         label = "bcm53xx:amber:power";
>                         gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
>                         linux,default-trigger = "default-off";
>                 };
>
> +               wan-white {
> +                       label = "bcm53xx:white:wan";
> +                       gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger = "default-on";
> +               };
> +
> +               wan-amber {
> +                       label = "bcm53xx:amber:wan";
> +                       gpios = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "default-off";
> +               };
> +
>                 5ghz-1 {
>                         label = "bcm53xx:white:5ghz-1";
>                         gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
> @@ -104,6 +116,12 @@
>                         linux,code = <KEY_RESTART>;
>                         gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
>                 };
> +
> +               brightness {
> +                       label = "Backlight";
> +                       linux,code = <KEY_BRIGHTNESS_ZERO>;
> +                       gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
> +               };
>         };
>  };

Changes look OK, thanks!

-- 
Rafa?
