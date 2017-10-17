From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 17 Oct 2017 13:40:17 +0200
Subject: [PATCH 3/4] ARM64: dts: meson-gx: grow reset controller memory
 zone
In-Reply-To: <1508228951-12384-4-git-send-email-narmstrong@baylibre.com>
References: <1508228951-12384-1-git-send-email-narmstrong@baylibre.com>
 <1508228951-12384-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <3adf8f94-39d7-5b3b-f313-2ac1fd4b3293@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/2017 10:29, Neil Armstrong wrote:
> Now the Amlogic Meson GX SoCs datasheet documents all the Reset registers,
> grow the memory in the node to allow usage of the level registers.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 80a0f2b..9b19656 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -220,7 +220,7 @@
>  
>  			reset: reset-controller at 4404 {
>  				compatible = "amlogic,meson-gx-reset", "amlogic,meson-gxbb-reset";
> -				reg = <0x0 0x04404 0x0 0x20>;
> +				reg = <0x0 0x04404 0x0 0x9c>;
>  				#reset-cells = <1>;
>  			};
>  
> 

Kevin,

This one can be applied now since Philipp took my reset patch.

Neil
