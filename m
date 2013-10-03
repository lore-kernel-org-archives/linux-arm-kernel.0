From: bcm@fixthebug.org (Christian Daudt)
Date: Wed, 2 Oct 2013 22:49:26 -0700
Subject: [PATCH v3] ARM: dts: bcm281xx: Add card detect GPIO
In-Reply-To: <1380736816-16230-1-git-send-email-markus.mayer@linaro.org>
References: <1380736816-16230-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <CAEPRUYrOV7M1AGuw-eW-0exTw0wT9SeD7xjOgmkZtGdNkDMuDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 2, 2013 at 11:00 AM, Markus Mayer <markus.mayer@linaro.org> wrote:
> Register GPIO 14 as card detect interrupt for the SD card slot.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> ---
>
> This patch depends on [PATCH v9 3/3] ARM: bcm281xx: Add device node for
> the GPIO controller
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/197399.html)
> and should therefore likely go into Christian's tree.
>
> Changes since v2:
> - Add "cd-gpios" to the affected dts files, not the dtsi
>
> Changes since v1:
> - Corrected commit message to mention "card detect"
>
>  arch/arm/boot/dts/bcm11351-brt.dts |    1 +
>  arch/arm/boot/dts/bcm28155-ap.dts  |    1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
> index 9d36eb4..23cd16d 100644
> --- a/arch/arm/boot/dts/bcm11351-brt.dts
> +++ b/arch/arm/boot/dts/bcm11351-brt.dts
> @@ -40,6 +40,7 @@
>
>         sdio4: sdio at 3f1b0000 {
>                 max-frequency = <48000000>;
> +               cd-gpios = <&gpio 14 0>;
>                 status = "okay";
>         };
>
> diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
> index 96ae67a..08e47c2 100644
> --- a/arch/arm/boot/dts/bcm28155-ap.dts
> +++ b/arch/arm/boot/dts/bcm28155-ap.dts
> @@ -40,6 +40,7 @@
>
>         sdio4: sdio at 3f1b0000 {
>                 max-frequency = <48000000>;
> +               cd-gpios = <&gpio 14 0>;
>                 status = "okay";
>         };
>  };
Reviewed-by: Christian Daudt <bcm@fixthebug.org>
Applied this one in replacement of v2.
 thanks,
   csd
