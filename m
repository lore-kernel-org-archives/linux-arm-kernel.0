From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 26 May 2014 14:45:27 +0100
Subject: [PATCH 1/2] arm: dts: Fix missing device_type="memory" for
 ste-ccu8540
In-Reply-To: <1401111769-5334-1-git-send-email-grant.likely@linaro.org>
References: <1401111769-5334-1-git-send-email-grant.likely@linaro.org>
Message-ID: <CACxGe6simd9e8zvrNdM1AG_i201TzvZM1gutB5odqwjg9DY7KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, sent this series out by mistake. Sorry for the noise.

g.

On Mon, May 26, 2014 at 2:42 PM, Grant Likely <grant.likely@linaro.org> wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
>
> The current .dts for ste-ccu8540 lacks a 'device_type = "memory"' for
> its memory node, relying on an old ppc quirk in order to discover its
> memory. Fix the data so that all parsing code can handle it correctly.
>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Grant Likely <grant.likely@linaro.org>
> ---
>  arch/arm/boot/dts/ste-ccu8540.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/ste-ccu8540.dts b/arch/arm/boot/dts/ste-ccu8540.dts
> index 7f3baf51a3a9..32dd55e5f4e6 100644
> --- a/arch/arm/boot/dts/ste-ccu8540.dts
> +++ b/arch/arm/boot/dts/ste-ccu8540.dts
> @@ -18,6 +18,7 @@
>         compatible = "st-ericsson,ccu8540", "st-ericsson,u8540";
>
>         memory at 0 {
> +               device_type = "memory";
>                 reg = <0x20000000 0x1f000000>, <0xc0000000 0x3f000000>;
>         };
>
> --
> 1.9.1
>
