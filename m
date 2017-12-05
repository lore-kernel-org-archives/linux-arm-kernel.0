From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 5 Dec 2017 11:24:44 +0800
Subject: [PATCH 9/9] arm64: dts: allwinner: a64: Enable sound on Pine64
 and SoPine
In-Reply-To: <20171203204157.20829-10-anarsoul@gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-10-anarsoul@gmail.com>
Message-ID: <CAGb2v65XC=0zwYu3Wjv0OcYrHfLbycBfaA4eW=HNN_8CzmcvRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 4, 2017 at 4:41 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> This commit enables I2S, digital and analog parts of audiocodec on
> Pine64 and SoPine boards.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts      | 16 ++++++++++++++++
>  .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 806442d3e846..369d9b749521 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -64,6 +64,18 @@
>         };
>  };
>
> +&codec {
> +       status = "okay";
> +};
> +
> +&codec_analog {
> +       status = "okay";
> +};
> +
> +&dai {
> +       status = "okay";
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> @@ -229,6 +241,10 @@
>         regulator-name = "vcc-rtc";
>  };
>
> +&sound {
> +       status = "okay";

This is missing all the board level widgets and routing.
Yes I know that it works right now, but that's because simple-card
isn't a strict card, i.e. it doesn't force the need for actual inputs
and outputs at both ends of the DAPM graph.

Later on you'll find that missing the routing leaves the microphone
unusable, because the microphone bias is not turned on.

ChenYu

> +};
> +
>  /* On Exp and Euler connectors */
>  &uart0 {
>         pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index 0eb2acedf8c3..9de5ddcc3656 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -69,6 +69,18 @@
>         };
>  };
>
> +&codec {
> +       status = "okay";
> +};
> +
> +&codec_analog {
> +       status = "okay";
> +};
> +
> +&dai {
> +       status = "okay";
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> @@ -133,6 +145,10 @@
>         regulator-name = "vcc-wifi";
>  };
>
> +&sound {
> +       status = "okay";
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pins_a>;
> --
> 2.15.0
>
