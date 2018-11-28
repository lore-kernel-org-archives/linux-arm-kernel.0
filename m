From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 11:03:43 +0800
Subject: [PATCH 04/77] ARM: dts: sun5i: Fix display pipeline endpoint
 warnings in DTC
In-Reply-To: <78b27a15e3e8c08ad565055a137d1954d5b0bb99.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <78b27a15e3e8c08ad565055a137d1954d5b0bb99.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64CueKNnrFmbikFh2UrCch4jFvs1Qn_6w6kjC06StayLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Since most of the display IPs have a single endpoint, having a reg
> property, a unit-address and #address-cells and #size-cells will emit a
> warning.
>
> Let's remove those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  arch/arm/boot/dts/sun5i.dtsi | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index 14a7d1cf89b4..3e7b251ce7a6 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi

[...]

> @@ -726,12 +720,9 @@
>                                 #size-cells = <0>;
>
>                                 fe0_out: port at 1 {
> -                                       #address-cells = <1>;
> -                                       #size-cells = <0>;
>                                         reg = <1>;
>
> -                                       fe0_out_be0: endpoint at 0 {
> -                                               reg = <0>;

Removing this breaks the code used to parse the graph to get the backend's ID.
The code expects a reg property to be present. We need to fix it.

The rest of the changes should be fine though.

ChenYu
