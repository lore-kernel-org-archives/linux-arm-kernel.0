From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 17:05:32 +0200
Subject: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output on Banana Pi M2
 Zero
In-Reply-To: <20180711132233.42301-2-icenowy@aosc.io>
References: <20180711132233.42301-1-icenowy@aosc.io>
 <20180711132233.42301-2-icenowy@aosc.io>
Message-ID: <20180711150532.6gzm7krouriddreh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
> Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
> controller of Allwinner H3 SoC.
> 
> Enable the HDMI output in Banana Pi M2 Zero device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> index 7d01f9322658..eb61dcf32797 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -26,6 +26,17 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "c";

This is not one of the connector type declared in DRM, how is it
exposed to the userspace?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/5191664c/attachment-0001.sig>
