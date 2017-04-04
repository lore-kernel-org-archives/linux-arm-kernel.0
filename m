From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 4 Apr 2017 10:41:05 +0200
Subject: [PATCH v2 08/13] ARM64: dts: meson-gx: Add shared CMA dma memory
 pool
In-Reply-To: <1490109950-21421-9-git-send-email-narmstrong@baylibre.com>
References: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
 <1490109950-21421-9-git-send-email-narmstrong@baylibre.com>
Message-ID: <43dd4aec-7002-5844-2e34-8507860a8268@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2017 04:25 PM, Neil Armstrong wrote:
> The HDMI modes needs more CMA memory to be reserved at boot-time.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 5d995f7..94c6f95 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -71,6 +71,14 @@
>  			reg = <0x0 0x10000000 0x0 0x200000>;
>  			no-map;
>  		};
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x0 0xbc00000>;
> +			alignment = <0x0 0x400000>;
> +			linux,cma-default;
> +		};
>  	};
>  
>  	cpus {
> 

Hi Kevin,

Please take this one for the amlogic arm-soc DT tree.

It may need a rebase, please tell me then I'll repost this one rebased on your 4.12/dt64 branch.

Thanks,
Neil
