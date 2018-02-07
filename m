From: david@lechnology.com (David Lechner)
Date: Wed, 7 Feb 2018 15:58:32 -0600
Subject: [PATCH 4/7] ARM: dts: da850: add power controller nodes
In-Reply-To: <20180207134553.13510-5-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <20180207134553.13510-5-brgl@bgdev.pl>
Message-ID: <41f32de3-5daa-75fd-51e9-e6dc1f7142a3@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add two power controller nodes corresponding with the two PSC modules
> present on the da850 SoC.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/boot/dts/da850.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 3a1f2ced05ca..ac2eef4e6b7c 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -24,6 +24,11 @@
>   		};
>   	};
>   
> +	aliases {
> +		pwc0 = &pwc0;
> +		pwc1 = &pwc1;
> +	};

Why do we need aliases? (would be nice to have the reason in the commit
message if there is a good reason)

> +
>   	opp_table: opp-table {
>   		compatible = "operating-points-v2";
>   
> @@ -141,6 +146,10 @@
>   				      "pll0_sysclk4", "pll0_sysclk6",
>   				      "async1";
>   		};
> +		pwc0: power-controller at 10000 {
> +			compatible = "ti,davinci-pm-domains";
> +			#power-domain-cells = <0>;
> +		};
>   		pll0: clock-controller at 11000 {
>   			compatible = "ti,da850-pll0";
>   			reg = <0x11000 0x1000>;
> @@ -757,6 +766,10 @@
>   				 <&async3_clk>;
>   			clock-names = "pll0_sysclk2", "pll0_sysclk4", "async3";
>   		};
> +		pwc1: power-controller at 227000 {
> +			compatible = "ti,davinci-pm-domains";
> +			#power-domain-cells = <0>;
> +		};
>   		pinconf: pin-controller at 22c00c {
>   			compatible = "ti,da850-pupd";
>   			reg = <0x22c00c 0x8>;
> 
