From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 10:17:17 +0200
Subject: [PATCH v2 09/18] arm64: dts: meson-gxbb-wetek-hub: Reference CVBS
 node by label
In-Reply-To: <20170513143337.14278-10-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-10-afaerber@suse.de>
Message-ID: <a335d752-3390-f3ba-c62c-f66f64da06a3@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2017 04:33 PM, Andreas F?rber wrote:
> Makes the override safer.
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Extended commit message
>  
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi     | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> index a5be438a5c03..0ec1d19522dd 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> @@ -126,7 +126,7 @@
>  		clock-names = "ext_clock";
>  	};
>  
> -	cvbs-connector {
> +	cvbs_connector: cvbs-connector {
>  		compatible = "composite-video-connector";
>  
>  		port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
> index f057fb48fee5..1878ac2b2b83 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
> @@ -59,10 +59,10 @@
>  			panic-indicator;
>  		};
>  	};
> +};
>  
> -	cvbs-connector {
> -		status = "disabled";
> -	};
> +&cvbs_connector {
> +	status = "disabled";
>  };
>  
>  &ethmac {
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
