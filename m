From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 30 Jun 2016 13:13:48 +0200
Subject: [linux-sunxi] [PATCH v2 14/14] ARM: dts: sun8i: Enable DVFS on
 Orange Pi One
In-Reply-To: <20160625034511.7966-15-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-15-megous@megous.com>
Message-ID: <CAOMqctTe==M1SXxbdR8y33yh51fiFGn+oSaKJXhbnpLVTn-New@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 25 June 2016 at 05:45,  <megous@megous.com> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Use Xulong Orange Pi One GPIO based regulator for
> passive cooling and thermal management.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 39 +++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> index b1bd6b0..a38d871 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> @@ -109,6 +109,45 @@
>         };
>  };
>
> +&cpu0 {
> +       operating-points = <
> +               /* kHz    uV */
> +               1296000 1300000
> +               1200000 1300000

First problem is that the board boots at 1008000 which is not listed
and the kernel complains.

Second problem is that the board locks up during boot with this enabled.

Do you have some suggestion for alternate configuration to test?

Thanks

Michal
