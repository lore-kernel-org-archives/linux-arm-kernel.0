From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 17 Mar 2017 08:48:25 +0100
Subject: [PATCH v4 3/7] mmc: bcm2835: add sdhost controller to devicetree
In-Reply-To: <1488964751-22763-6-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
 <1488964751-22763-6-git-send-email-kraxel@redhat.com>
Message-ID: <CAPDyKFpX-P+K+88BNmkL0G7k0afqs_mSCcZS=ZVSavuhBjpCKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- trimmed cc-list

On 8 March 2017 at 10:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Eric Anholt <eric@anholt.net>

Again this is arm soc material. You need to change the prefix of the
commit msg to also reflect that.

*If* I am going to pick this up I need acks.

Kind regards
Uffe

> ---
>  arch/arm/boot/dts/bcm2835-rpi.dtsi |  6 ++++++
>  arch/arm/boot/dts/bcm283x.dtsi     | 10 ++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index 1e00a28..8b95832 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -69,6 +69,12 @@
>         bus-width = <4>;
>  };
>
> +&sdhost {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdhost_gpio48>;
> +       bus-width = <4>;
> +};
> +
>  &pwm {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 9798bc9..19099a5 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -350,6 +350,16 @@
>                         arm,primecell-periphid = <0x00241011>;
>                 };
>
> +               sdhost: mmc at 7e202000 {
> +                       compatible = "brcm,bcm2835-sdhost";
> +                       reg = <0x7e202000 0x100>;
> +                       interrupts = <2 24>;
> +                       clocks = <&clocks BCM2835_CLOCK_VPU>;
> +                       dmas = <&dma 13>;
> +                       dma-names = "rx-tx";
> +                       status = "disabled";
> +               };
> +
>                 i2s: i2s at 7e203000 {
>                         compatible = "brcm,bcm2835-i2s";
>                         reg = <0x7e203000 0x20>,
> --
> 1.8.3.1
>
