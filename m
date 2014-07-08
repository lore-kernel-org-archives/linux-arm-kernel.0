From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Jul 2014 22:46:52 -0700
Subject: [PATCH 1/2] ARM: efm32: switch to properly namespaced location
 property
In-Reply-To: <1404142889-20740-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20140630154030.GJ14781@pengutronix.de>
 <1404142889-20740-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOesGMjzzYwXKXZLvUVp-nAGf+R4G8eUjK+3CumB8i5LkoRCow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 30, 2014 at 8:41 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Now that both spi and serial driver support these (commits f2bb31057a42
> (spi: efm32: properly namespace location property) and
> 74be65a3cff5 (serial: efm32: properly namespace location property)) use
> the better names.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/efm32gg-dk3750.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
> index b4031fa4a567..d5dd2a2a7970 100644
> --- a/arch/arm/boot/dts/efm32gg-dk3750.dts
> +++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
> @@ -43,7 +43,7 @@
>
>                 spi0: spi at 4000c000 { /* USART0 */
>                         cs-gpios = <&gpio 68 1>; // E4
> -                       location = <1>;
> +                       efm32,location = <1>;

Hrm, the prefix is normally the vendor, not the platform. I see that
the bindings have already been merged though. Sorry, I completely
missed that the first time around. :(

Probably not a whole lot to do about it in this case. It's not the end
of the world anyway, efm32 is a sufficiently unique string as it is.


-Olof
