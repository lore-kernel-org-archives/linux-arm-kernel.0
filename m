From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 6 Dec 2016 21:24:50 +0200
Subject: [PATCH 5/5] arm64: dts: exynos5433: Add support of bus frequency
 using VDD_INT on TM2
In-Reply-To: <1480663087-4590-6-git-send-email-cw00.choi@samsung.com>
References: <1480663087-4590-1-git-send-email-cw00.choi@samsung.com>
 <1480663087-4590-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <20161206192450.GC12683@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 04:18:07PM +0900, Chanwoo Choi wrote:
> This patch adds the bus Device-tree nodes for INT (Internal) block
> to enable the bus frequency scaling.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 72 +++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index c08589970134..7b37aae336b1 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -170,6 +170,58 @@
>  	};
>  };
>  
> +&bus_g2d_400 {
> +	devfreq-events = <&ppmu_event0_d0_general>, <&ppmu_event0_d1_general>;
> +	vdd-supply = <&buck4_reg>;
> +	exynos,saturation-ratio = <10>;
> +	status = "okay";
> +};
> +
> +&bus_mscl {
> +	devfreq = <&bus_g2d_400>;
> +	status = "okay";
> +};
> +
> +&bus_jpeg {

Except the first entry (which is a parent), are there any objections to
order these nodes alphabetically? This also applies to the previously
patch.

Beside that nit, looks good. I will have to wait anyway to next merge
window, so for the reference:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> +	devfreq = <&bus_g2d_400>;
> +	status = "okay";
> +};
> +
> +&bus_mfc {
> +	devfreq = <&bus_g2d_400>;
> +	status = "okay";
> +};
> +
> +&bus_g2d_266 {
> +	devfreq = <&bus_g2d_400>;
> +	status = "okay";
> +};
> +
> +&bus_gscl {
> +	devfreq = <&bus_g2d_400>;
> +	status = "okay";
> +};
> +
> +&bus_hevc {
> +	devfreq = <&bus_g2d_400>;
> +	status = "okay";
> +};
> +
> +&bus_bus0 {
> +	devfreq = <&bus_g2d_400>;
> +	status = "okay";
> +};
> +
> +&bus_bus1 {
> +	devfreq = <&bus_g2d_400>;
> +	status = "okay";
> +};
> +
> +&bus_bus2 {
> +	devfreq = <&bus_g2d_400>;
> +	status = "okay";
> +};
> +
>  &cmu_aud {
>  	assigned-clocks = <&cmu_aud CLK_MOUT_AUD_PLL_USER>;
>  	assigned-clock-parents = <&cmu_top CLK_FOUT_AUD_PLL>;
> @@ -794,6 +846,26 @@
>  	bus-width = <4>;
>  };
>  
> +&ppmu_d0_general {
> +	status = "okay";
> +
> +	events {
> +		ppmu_event0_d0_general: ppmu-event0-d0-general {
> +			event-name = "ppmu-event0-d0-general";
> +		};
> +	};
> +};
> +
> +&ppmu_d1_general {
> +	status = "okay";
> +
> +	events {
> +		ppmu_event0_d1_general: ppmu-event0-d1-general {
> +		       event-name = "ppmu-event0-d1-general";
> +	       };
> +       };
> +};
> +
>  &pinctrl_alive {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&initial_alive>;
> -- 
> 1.9.1
> 
