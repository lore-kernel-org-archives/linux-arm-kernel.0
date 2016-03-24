From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 24 Mar 2016 19:12:34 +0100
Subject: [PATCH v2 1/4] ARM64: dts: amlogic: update serial aliases
In-Reply-To: <1458842715-27066-2-git-send-email-khilman@baylibre.com>
References: <1458842715-27066-1-git-send-email-khilman@baylibre.com>
 <1458842715-27066-2-git-send-email-khilman@baylibre.com>
Message-ID: <56F42E12.5020404@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.03.2016 um 19:05 schrieb Kevin Hilman:
> Apparently, it's not valid to have an alias point to a disabled device.
> Fix this by moving the aliases that are used (serial0) into the files
> that use them, and remove aliases to disabled devices (serial1).
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 4 ++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 5 -----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> index c1fa2667ec5c..012cdccc8a35 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> @@ -45,6 +45,10 @@
>  / {
>  	compatible = "tronsmart,vega-s95", "amlogic,meson-gxbb";
>  
> +	aliases {
> +		serial0 = &uart_AO;
> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index eaa0a4553734..832815d80462 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -50,11 +50,6 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> -	aliases {
> -		serial0 = &uart_AO;
> -		serial1 = &uart_A;
> -	};
> -
>  	cpus {
>  		#address-cells = <0x2>;
>  		#size-cells = <0x0>;

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
