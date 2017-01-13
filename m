From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 13 Jan 2017 16:36:17 +0100
Subject: [PATCH] arm64: dts: mt8173: Fix cpu_thermal cooling-maps
 contributions
In-Reply-To: <20170113023006.150845-1-djkurtz@chromium.org>
References: <20170113023006.150845-1-djkurtz@chromium.org>
Message-ID: <ac6266a7-b540-8fdd-7ece-ef4871cceaae@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/01/17 03:30, Daniel Kurtz wrote:
> According to [0], the contribution field for each cooling-device express
> their relative power efficiency. Higher weights express higher power
> efficiency.  Weighting is relative such that if each cooling device has a
> weight of 1 they are considered equal. This is particularly useful in
> heterogeneous systems where two cooling devices may perform the same kind
> of compute, but with different efficiency.
>
> [0] Documentation/thermal/power_allocator.txt
>
> According to Mediatek IC designer, the power efficiency ratio between the
> LITTLE core cluster (cooling-device cpu0) and big core cluster
> (cooling-device cpu1) is around 3:1 (3072:1024).
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

applied, thanks.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 12e702771f5c..9a3b0d20f7a8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -182,12 +182,12 @@
>  				map at 0 {
>  					trip = <&target>;
>  					cooling-device = <&cpu0 0 0>;
> -					contribution = <1024>;
> +					contribution = <3072>;
>  				};
>  				map at 1 {
>  					trip = <&target>;
>  					cooling-device = <&cpu2 0 0>;
> -					contribution = <2048>;
> +					contribution = <1024>;
>  				};
>  			};
>  		};
>
