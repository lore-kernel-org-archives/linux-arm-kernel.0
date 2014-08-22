From: robherring2@gmail.com (Rob Herring)
Date: Thu, 21 Aug 2014 22:12:47 -0500
Subject: [RFC PATCH 4/6] powerpc/85xx: Change vendor prefix for Intersil
 Corporation to isil
In-Reply-To: <1408524184-31928-5-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
 <1408524184-31928-5-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAL_JsqK3Wi9b=7w=Npu3HN8SSkyFgVT0Qoc48LUyoiEaBjSCTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 3:43 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Currently there is a wild mixture of isl, isil, and intersil
> compatibles in the kernel. At this point, changing the vendor
> symbol to the most often used variant, which is equal to the
> NASDAQ symbol, isil, should not hurt, since the isl1208 driver
> doesn't care either way.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/powerpc/boot/dts/ppa8548.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/dts/ppa8548.dts b/arch/powerpc/boot/dts/ppa8548.dts
> index 27b0699..000262b 100644
> --- a/arch/powerpc/boot/dts/ppa8548.dts
> +++ b/arch/powerpc/boot/dts/ppa8548.dts
> @@ -89,7 +89,7 @@
>  &soc {
>         i2c at 3000 {
>                 rtc at 6f {
> -                       compatible = "intersil,isl1208";
> +                       compatible = "isil,isl1208";

This is a mature platform. You cannot change it. You can add the new
string, but the dts and kernel need both strings.

I would just leave it all alone and add the new prefix and mark the
others deprecated.

Rob

>                         reg = <0x6f>;
>                 };
>         };
> --
> 2.1.0.rc1
>
