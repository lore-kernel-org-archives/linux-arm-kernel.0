From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 6 Feb 2017 10:29:34 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb: set reset for ethernet
In-Reply-To: <ec31eddc-d286-d0bc-0bdb-ae9d5014d82e@gmail.com>
References: <ec31eddc-d286-d0bc-0bdb-ae9d5014d82e@gmail.com>
Message-ID: <259f7102-591b-f251-5844-a864fa39e137@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2017 03:07 PM, Heiner Kallweit wrote:
> Add reset control for ethernet.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 39a774ad..753fddf6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -113,6 +113,8 @@
>  		 <&clkc CLKID_FCLK_DIV2>,
>  		 <&clkc CLKID_MPLL2>;
>  	clock-names = "stmmaceth", "clkin0", "clkin1";
> +	resets = <&reset RESET_ETHERNET>;
> +	reset-names = "stmmaceth";
>  };
>  
>  &aobus {
> 

Hi,

Actually this is a no-op since the Amlogic reset controller only supports "pulse" resets and the
STMMAC driver only supports "level" resets. If you want to use this reset, you must add the
corresponding support code in the meson8b glue code to call device_reset().

Neil
