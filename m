From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 06 Jul 2015 13:17:13 +0300
Subject: [PATCH] ARM: shmobile: kzm9g dts: Add adxl345-specific compatible
 property
In-Reply-To: <1436176746-10995-1-git-send-email-geert+renesas@glider.be>
References: <1436176746-10995-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1980362.9qv8Mc7ut7@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Monday 06 July 2015 11:59:06 Geert Uytterhoeven wrote:
> The accelerometer node used the generic compatible property only.
> Add the device-specific one, to make it future proof.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF match
> support"), which is in v4.2-rc1.
> ---
>  arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> b/arch/arm/boot/dts/sh73a0-kzm9g.dts index
> 24b4cd24dceb2f9e..ae91278d77b45b38 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
> @@ -206,7 +206,7 @@
>  	};
> 
>  	accelerometer at 1d {
> -		compatible = "adi,adxl34x";
> +		compatible = "adi,adxl345", "adi,adxl34x";

"adi,adxl34x" is deprecated and shouldn't be used in DT. You can just specify 
"adi,adxl345".

>  		reg = <0x1d>;
>  		interrupt-parent = <&irqpin3>;
>  		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,

-- 
Regards,

Laurent Pinchart
