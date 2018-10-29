From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon, 29 Oct 2018 14:47:11 +0530
Subject: [PATCH v2 7/7] arm64: dts: qcom: apq8016-sbc: Standardize LED
 labels
In-Reply-To: <20181029090006.4353-8-manivannan.sadhasivam@linaro.org>
References: <20181029090006.4353-1-manivannan.sadhasivam@linaro.org>
 <20181029090006.4353-8-manivannan.sadhasivam@linaro.org>
Message-ID: <CAHLCerM91ukzAJZHaxXxwoHU-6mVUV+X9_y_Rs0zmybNnRJCfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 2:31 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> For all 96Boards, the following standard is used for onboard LEDs.
>
> green:user1  default-trigger: heartbeat
> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> green:user3  default-trigger: mmc1 (SD-card)
> green:user4  default-trigger: none, panic-indicator
> yellow:wlan  default-trigger: phy0tx
> blue:bt      default-trigger: hci0-power
>
> So lets adopt the same for APQ8016 SBC (Dragonboard410c), which is
> one of the 96Boards CE platform.

You are missing a signed-off here :-)

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> index 46feedf7c989..35f95154316b 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> @@ -300,28 +300,28 @@
>                         compatible = "gpio-leds";
>
>                         led at 1 {
> -                               label = "apq8016-sbc:green:user1";
> +                               label = "green:user1";
>                                 gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "heartbeat";
>                                 default-state = "off";
>                         };
>
>                         led at 2 {
> -                               label = "apq8016-sbc:green:user2";
> +                               label = "green:user2";
>                                 gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "mmc0";
>                                 default-state = "off";
>                         };
>
>                         led at 3 {
> -                               label = "apq8016-sbc:green:user3";
> +                               label = "green:user3";
>                                 gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "mmc1";
>                                 default-state = "off";
>                         };
>
>                         led at 4 {
> -                               label = "apq8016-sbc:green:user4";
> +                               label = "green:user4";
>                                 gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "none";
>                                 panic-indicator;
> @@ -329,14 +329,14 @@
>                         };
>
>                         led at 5 {
> -                               label = "apq8016-sbc:yellow:wlan";
> +                               label = "yellow:wlan";
>                                 gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "phy0tx";
>                                 default-state = "off";
>                         };
>
>                         led at 6 {
> -                               label = "apq8016-sbc:blue:bt";
> +                               label = "blue:bt";
>                                 gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "bluetooth-power";
>                                 default-state = "off";
> --
> 2.17.1
>
