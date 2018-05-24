From: mdf@kernel.org (Moritz Fischer)
Date: Thu, 24 May 2018 10:04:59 -0700
Subject: [PATCHv5 2/8] arm64: dts: stratix10: add stratix10 service
 driver binding to base dtsi
In-Reply-To: <1527179600-26441-3-git-send-email-richard.gong@linux.intel.com>
References: <1527179600-26441-1-git-send-email-richard.gong@linux.intel.com>
 <1527179600-26441-3-git-send-email-richard.gong@linux.intel.com>
Message-ID: <20180524170459.GB4051@archbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Thu, May 24, 2018 at 11:33:14AM -0500, richard.gong at linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add Intel Stratix10 service layer to the device tree
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: Change to put service layer driver node under the firmware node
>     Change compatible to "intel, stratix10-svc"
> v3: No change
> v4: s/service driver/stratix10 service driver/ in subject line
> v5: No change
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index d8c94d5..c257287 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -24,6 +24,19 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		service_reserved: svcbuffer at 0 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x0 0x0 0x1000000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -487,5 +500,13 @@
>  
>  			status = "disabled";
>  		};
> +
> +		firmware {
> +			svc {
> +				compatible = "intel,stratix10-svc";
> +				method = "smc";
> +				memory-region = <&service_reserved>;
> +			};
> +		};
>  	};
>  };
> -- 
> 2.7.4
> 
