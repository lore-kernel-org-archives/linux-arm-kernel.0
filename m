From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Mar 2016 11:03:49 +0800
Subject: [PATCH 1/2] ARM: sun4i: dt: Enable dram gate 5 (tve0 clock) for
 simplefb TV output
In-Reply-To: <1458842920-30854-2-git-send-email-Priit.Laes@icefire.ee>
References: <1458842920-30854-1-git-send-email-Priit.Laes@icefire.ee>
 <1458842920-30854-2-git-send-email-Priit.Laes@icefire.ee>
Message-ID: <CAGb2v64sOvNn0Cwv+y7jKyMhyXmPYkwL9COQqhxAuDE6DLnRhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 2:08 AM, Priit Laes <Priit.Laes@icefire.ee> wrote:
> From: Priit Laes <plaes@plaes.org>
>
> Seems like dram_gate 5 was forgotten when DRAM gate driver was added.
>
> Enable it.
>
> Signed-off-by: Priit Laes <plaes@plaes.org>

Fixes: 82f8582feef4 ("ARM: dts: sun4i: Add DRAM gates")

Thanks!

> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 2c8f5e6..bf70d0a 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -96,7 +96,7 @@
>                         allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
>                         clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
>                                  <&ahb_gates 44>, <&ahb_gates 46>,
> -                                <&dram_gates 25>, <&dram_gates 26>;
> +                                <&dram_gates 5>, <&dram_gates 25>, <&dram_gates 26>;
>                         status = "disabled";
>                 };
>         };
> --
> 2.5.0
>
