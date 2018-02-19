From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Mon, 19 Feb 2018 15:34:51 +0100
Subject: [PATCH v3 6/6] arm64: dts: rockchip: Specify override mode for
 kevin panel
In-Reply-To: <20180208174855.55620-7-seanpaul@chromium.org>
References: <20180208174855.55620-1-seanpaul@chromium.org>
 <20180208174855.55620-7-seanpaul@chromium.org>
Message-ID: <CAFqH_53Z7qTi8jKcjBpEawFQW3imzOks+qFh5dqMuD4XGETv+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-08 18:48 GMT+01:00 Sean Paul <seanpaul@chromium.org>:
> This patch adds an override mode for kevin devices. The mode increases
> both back porches to allow a pixel clock of 26666kHz as opposed to the
> 'typical' value of 252750kHz. This is needed to avoid interference with
> the touch digitizer on these laptops.
>
> Changes in v2:
>  - Wrap the timing in display-timings node to match binding (Rob/Thierry)
> Changes in v3:
>  - Unwrap the timing from display-timings and rename panel-timing (Rob)
>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: St?phane Marchesin <marcheu@chromium.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: devicetree at vger.kernel.org
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-rockchip at lists.infradead.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> index 191a6bcb1704..658411ce37ea 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> @@ -98,6 +98,20 @@
>                 backlight = <&backlight>;
>                 power-supply = <&pp3300_disp>;
>
> +               panel-timing {
> +                       clock-frequency = <266604720>;
> +                       hactive = <2400>;
> +                       hfront-porch = <48>;
> +                       hback-porch = <84>;
> +                       hsync-len = <32>;
> +                       hsync-active = <0>;
> +                       vactive = <1600>;
> +                       vfront-porch = <3>;
> +                       vback-porch = <120>;
> +                       vsync-len = <10>;
> +                       vsync-active = <0>;
> +               };
> +
>                 ports {
>                         panel_in_edp: endpoint {
>                                 remote-endpoint = <&edp_out_panel>;
> --


Tested on top of linux-next on a Samsung Chromebook Plus.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> 2.16.0.rc1.238.g530d649a79-goog
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
