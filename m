From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 5 Dec 2016 08:32:12 -0600
Subject: [PATCH v3 1/2] ARM: dts: da850-lcdk: add the dumb-vga-dac node
In-Reply-To: <1480420624-23544-2-git-send-email-bgolaszewski@baylibre.com>
References: <1480420624-23544-1-git-send-email-bgolaszewski@baylibre.com>
 <1480420624-23544-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <CAL_Jsq+OKbSvu0bG8KNtw4tsLH46B2Vnb9ZampPafCum4xSZWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 5:57 AM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> Add the dumb-vga-dac node to the board DT together with corresponding
> ports and vga connector. This allows to retrieve the edid info from
> the display automatically.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 58 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/da850.dtsi     | 17 ++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index 711b9ad..d864f11 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -50,6 +50,53 @@
>                         system-clock-frequency = <24576000>;
>                 };
>         };
> +
> +       vga_bridge {

s/_/-/

> +               compatible = "dumb-vga-dac";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&lcd_pins>;

Are these pins from the LCD controller? They should be part of the LCD
controller node.

Rob
