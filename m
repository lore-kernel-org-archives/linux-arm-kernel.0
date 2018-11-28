From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 21:07:24 +0800
Subject: [PATCH 77/77] ARM: dts: sun9i: Add missing unit address
In-Reply-To: <39e9a2c3caec8bf63469f65563361b39c85b607a.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <39e9a2c3caec8bf63469f65563361b39c85b607a.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67atuezsjqb-1-0e7Nr1Rt=Fz7TfQhq8R-+meUpDd-M6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The soc node in the A80 DTSI has a ranges property, but no matching unit
> address, which results in a DTC warning. Add the unit address to remove
> that warning.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index 27c2ad6bf002..ec504cea1b3e 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -254,7 +254,7 @@
>                 status = "disabled";
>         };
>
> -       soc {
> +       soc at 20000 {

Shouldn't it be 0? The BROM, though unlisted, is at 0x0.

ChenYu
