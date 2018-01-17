From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 17 Jan 2018 09:38:53 +0100
Subject: [PATCH] ARM64: dts: meson: enable passing MAC addr on u-boot
 environment
In-Reply-To: <1516122805-20227-1-git-send-email-jramirez@baylibre.com>
References: <1516122805-20227-1-git-send-email-jramirez@baylibre.com>
Message-ID: <dbbf50b8-7911-14d3-7357-e9f153b1ab71@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jorge,

On 16/01/2018 18:13, Jorge Ramirez-Ortiz wrote:
> From: Jorge Ramirez-Ortiz <jramirez@baylibre.org>
> 
> With the adequate configuration settings, u-boot will loop through the
> list of aliases looking for "ethernetX".
> 
> By adding an ethernet alias, u-boot can fixup the local-mac-address
> property in the kernel's device tree using a value held in its
> environment variable ethaddr.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index 68d2c90..8ed2a98 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -18,6 +18,7 @@
>  
>  	aliases {
>  		serial0 = &uart_AO;
> +		ethernet = &ethmac;

Isn't it ethernet0 instead ?

>  	};
>  
>  	chosen {
> 

It would be great to have this on all boards with ethernet enabled.

Neil
