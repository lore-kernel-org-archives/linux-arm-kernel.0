From: carlo@caione.org (Carlo Caione)
Date: Fri, 20 May 2016 10:47:48 +0200
Subject: [PATCH 3/3] ARM64: dts: amlogic: Enable Reset Controller on
 GXBB-based platforms
In-Reply-To: <1463732875-23141-4-git-send-email-narmstrong@baylibre.com>
References: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
 <1463732875-23141-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160520084748.GC16732@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/16 10:27, Neil Armstrong wrote:
> Update DTSI file to add the reset controller node.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 832815d..2463e04 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -129,6 +129,12 @@
>  			#size-cells = <2>;
>  			ranges = <0x0 0x0 0x0 0xc1100000 0x0 0x100000>;
>  
> +			reset: reset-controller at 4404 {
> +				compatible = "amlogic,meson-gxbb-reset";
> +				reg = <0x0 0x04404 0x0 0x20>;
> +				#reset-cells = <1>;
> +			};
> +
>  			uart_A: serial at 84c0 {
>  				compatible = "amlogic,meson-uart";
>  				reg = <0x0 0x084c0 0x0 0x14>;

Missing #include <dt-bindings/reset/amlogic,meson-gxbb-reset.h> ?

Thanks,

-- 
Carlo Caione
