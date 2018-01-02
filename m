From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 2 Jan 2018 20:42:36 +0100
Subject: [PATCH] Nokia N9: add support for up/down keys in the dts
In-Reply-To: <20180102125948.GA20051@amd>
References: <20180102125948.GA20051@amd>
Message-ID: <20180102194236.ahrhkvnefre2l6gf@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 02, 2018 at 01:59:48PM +0100, Pavel Machek wrote:
> 
> This adds support for volume up/down keys in the dts.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> 
> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
> index 39e35f8..57a6679 100644
> --- a/arch/arm/boot/dts/omap3-n9.dts
> +++ b/arch/arm/boot/dts/omap3-n9.dts
> @@ -11,9 +11,10 @@
>  /dts-v1/;
>  
>  #include "omap3-n950-n9.dtsi"
> +#include <dt-bindings/input/input.h>
>  
>  / {
>  	model = "Nokia N9";
>  	compatible = "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
>  };
>  
> @@ -72,3 +133,9 @@
>  	st,max-limit-y = <46>;
>  	st,max-limit-z = <46>;
>  };
> +
> +&twl_keypad {
> +	linux,keymap = < MATRIX_KEY(6, 8, KEY_VOLUMEUP)
> +			 MATRIX_KEY(7, 8, KEY_VOLUMEDOWN)
> +			 >;
> +};
> 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180102/1fd5da38/attachment.sig>
