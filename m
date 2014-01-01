From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 1 Jan 2014 20:45:32 +0100
Subject: [PATCH 3/4] ARM: dts: sun5i: Add lradc node
In-Reply-To: <1388604610-20380-4-git-send-email-hdegoede@redhat.com>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <1388604610-20380-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20140101194532.GQ32537@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 01, 2014 at 08:30:09PM +0100, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 7 +++++++
>  arch/arm/boot/dts/sun5i-a10s.dtsi                | 7 +++++++
>  arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 7 +++++++
>  arch/arm/boot/dts/sun5i-a13.dtsi                 | 7 +++++++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> index e53fb12..c32162e 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> @@ -75,6 +75,13 @@
>  			};
>  		};
>  
> +		lradc: lradc at 01c22800 {
> +			allwinner,chan0-step = <200>;
> +			/* KEY_VOLUMEUP VOLUMEDOWN MENU ENTER HOME */
> +			allwinner,chan0-keycodes = <115 114 139 28 102>;

Hi Hans

You might want to consider using arch/arm/boot/dts/include/dt-bindings/input/input.h

and then you could have the node:

> +		lradc: lradc at 01c22800 {
> +			allwinner,chan0-step = <200>;
> +			allwinner,chan0-keycodes = <KEY_VOLUMEUP VOLUMEDOWN MENU ENTER HOME>;

which is much more readable.

      Andrew
