From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 16 Jul 2018 12:11:06 +0200
Subject: [PATCH] dts/droid4: fix dts w.r.t. pwm
In-Reply-To: <20180716071048.GA23110@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd> <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
 <20180716071048.GA23110@amd>
Message-ID: <20180716101106.vgmjz3ic7gqy2u2q@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 16, 2018 at 09:10:48AM +0200, Pavel Machek wrote:
> pwm node should not be under gpio6 node in the device tree.
>    
> This fixes detection of the pwm on Droid 4.
>     
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> index 45305e8..c27fc87 100644
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -159,13 +159,7 @@
>  
>  		dais = <&mcbsp2_port>, <&mcbsp3_port>;
>  	};
> -};
> -
> -&dss {
> -	status = "okay";
> -};
>  
> -&gpio6 {
>  	pwm8: dmtimer-pwm-8 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&vibrator_direction_pin>;
> @@ -192,7 +186,10 @@
>  		pwm-names = "enable", "direction";
>  		direction-duty-cycle-ns = <10000000>;
>  	};
> +};
>  
> +&dss {
> +	status = "okay";
>  };
>  
>  &dsi1 {
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180716/916d8d71/attachment.sig>
