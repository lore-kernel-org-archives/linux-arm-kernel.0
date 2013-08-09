From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 8 Aug 2013 23:22:43 -0300
Subject: [PATCH 1/1] ARM: dtsi: imx6qdl-sabresd: Add USB host 1 VBUS
 regulator
In-Reply-To: <1376007824-16325-1-git-send-email-peter.chen@freescale.com>
References: <1376007824-16325-1-git-send-email-peter.chen@freescale.com>
Message-ID: <CAOMZO5AXprz7MsxmyWB_nH8pc0GX3sbcZUtDqEVkf0W9myBbxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 8, 2013 at 9:23 PM, Peter Chen <peter.chen@freescale.com> wrote:
> We enabled USB host 1, so host 1's vbus should be on to let
> host 1 work.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 6e5dfdb..6e9d4d7 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -27,6 +27,15 @@
>                         enable-active-high;
>                 };
>
> +               reg_usb_h1_vbus: usb_h1_vbus {
> +                       compatible = "regulator-fixed";
> +                       regulator-name = "usb_h1_vbus";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       gpio = <&gpio1 29 0>;

You should also add en entry into pinctrl_hog for this gpio.
