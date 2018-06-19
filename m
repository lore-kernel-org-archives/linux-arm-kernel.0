From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 Jun 2018 09:26:50 +0200
Subject: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
In-Reply-To: <20180618174216.24801-2-krzk@kernel.org>
References: <20180618174216.24801-1-krzk@kernel.org>
 <CGME20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f@epcas1p3.samsung.com>
 <20180618174216.24801-2-krzk@kernel.org>
Message-ID: <20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2018-06-18 19:42, Krzysztof Kozlowski wrote:
> The decon, decon_tv and dsi nodes have only one child port so
> address/size mappings are not necessary.  This fixes DTC warnings like:
>
>      Warning (graph_child_address): /soc/decon at 13800000/ports:
>          graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Works fine with current Exynos DRM Decon/MIC/DSI drivers.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi |  6 +-----
>   arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 12 ++----------
>   2 files changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index a1e3194b7483..0a15ee513f5c 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -321,11 +321,7 @@
>   	status = "okay";
>   
>   	ports {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		port at 0 {
> -			reg = <0>;
> +		port {
>   			tv_to_hdmi: endpoint {
>   				remote-endpoint = <&hdmi_to_tv>;
>   			};
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 3a9b4c4b9c63..e4367fd39120 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -850,11 +850,7 @@
>   			iommu-names = "m0", "m1";
>   
>   			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> +				port {
>   					decon_to_mic: endpoint {
>   						remote-endpoint =
>   							<&mic_to_decon>;
> @@ -914,11 +910,7 @@
>   			#size-cells = <0>;
>   
>   			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> +				port {
>   					dsi_to_mic: endpoint {
>   						remote-endpoint = <&mic_to_dsi>;
>   					};

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
