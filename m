From: dianders@google.com (Doug Anderson)
Date: Fri, 13 Jun 2014 10:03:50 -0700
Subject: [PATCH 3/3] ARM: dts: Enable audio support for Peach-pi board
In-Reply-To: <1402464739-19044-4-git-send-email-tushar.b@samsung.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-4-git-send-email-tushar.b@samsung.com>
Message-ID: <CAD=FV=XqqP7+xDOAKCixivzgaO0xvJX7L+CCN+unAEuf-6aUbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar,

On Tue, Jun 10, 2014 at 10:32 PM, Tushar Behera <tushar.b@samsung.com> wrote:
> Peach-pi board has MAX98090 audio codec connected on HSI2C-7 bus.

If you want to be a stickler about it, peach-pi actually has a
max98091.  That requires code changes to the i2c driver, though.
...and unfortunately listing two compatible strings for i2c devices is
broken.  :(


> Signed-off-by: Tushar Behera <tushar.b@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5800-peach-pi.dts |   31 +++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index f3af207..76f5966 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -78,9 +78,27 @@
>                 pinctrl-0 = <&usb301_vbus_en>;
>                 enable-active-high;
>         };
> +
> +       sound {
> +               compatible = "google,snow-audio-max98090";
> +
> +               samsung,i2s-controller = <&i2s0>;
> +               samsung,audio-codec = <&max98090>;
> +       };
> +};
> +
> +&i2s0 {
> +       status = "okay";

It would be awfully nice to keep diffs between exynos5420-peach-pit
and exynos5800-peach-pi clean.  They're 99% the same.  I know this has
already gotten messed up with DP/HDMI were added, but there's no need
to make it worse.

Could you add these nodes in the same place within the dts they were
added in exynos5420-peach-pit?
