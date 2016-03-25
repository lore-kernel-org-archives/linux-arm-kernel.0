From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Mar 2016 11:04:15 +0800
Subject: [PATCH 2/2] ARM: sun7i: dt: Enable dram gate 5 (tve0 clock) for
 simplefb TV output
In-Reply-To: <1458842920-30854-3-git-send-email-Priit.Laes@icefire.ee>
References: <1458842920-30854-1-git-send-email-Priit.Laes@icefire.ee>
 <1458842920-30854-3-git-send-email-Priit.Laes@icefire.ee>
Message-ID: <CAGb2v67Gw9BJHmsSeLWE8PTh4Y2Kxa4Dj=N=T6T_-j0i8xLaog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 2:08 AM, Priit Laes <Priit.Laes@icefire.ee> wrote:
> From: Priit Laes <plaes@plaes.org>
>
> Seems like dram_gate 5 was forgotten when DRAM gating driver was added.
>
> Enable it.
>
> Signed-off-by: Priit Laes <plaes@plaes.org>


Fixes: 0b4bf5a5200b ("ARM: dts: sun7i: Add DRAM gates")

Thanks!

> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 0940a78..ee4e8e7 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -85,8 +85,9 @@
>                         compatible = "allwinner,simple-framebuffer",
>                                      "simple-framebuffer";
>                         allwinner,pipeline = "de_be0-lcd0-tve0";
> -                       clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
> -                                <&ahb_gates 44>, <&dram_gates 26>;
> +                       clocks = <&pll5 1>,
> +                                <&ahb_gates 34>, <&ahb_gates 36>, <&ahb_gates 44>,
> +                                <&dram_gates 5>, <&dram_gates 26>;
>                         status = "disabled";
>                 };
>         };
> --
> 2.5.0
>
