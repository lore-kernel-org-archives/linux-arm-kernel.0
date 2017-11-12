From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 12 Nov 2017 15:29:18 +0100
Subject: [PATCH] omap3-n900: enable autofocus
In-Reply-To: <20171112112528.GA21009@amd>
References: <20171112112528.GA21009@amd>
Message-ID: <20171112142918.rqxd2uk7ljyhpctt@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 12, 2017 at 12:25:29PM +0100, Pavel Machek wrote:
> 
> Connect auto-focus coil to the camera sensor, so that it can be used
> by camera applications.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

I think you should replace auto-focus with lens-focus. This is not
automatic. Otherwise:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 669c51c..59cc743 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -778,6 +778,8 @@
>  
>  		reset-gpio = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
>  
> +		lens-focus = <&ad5820>;
> +
>  		port {
>  			csi_cam1: endpoint {
>  				bus-type = <3>; /* CCP2 */
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171112/8566b3fa/attachment.sig>
