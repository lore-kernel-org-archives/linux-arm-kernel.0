From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 1 Jun 2018 14:59:45 -0600
Subject: [RFC PATCH 8/8] dts: juno: Update coresight bindings for hw port
In-Reply-To: <1527858967-16047-9-git-send-email-suzuki.poulose@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180601205945.GE9838@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 02:16:07PM +0100, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for hw ports.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-and-tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 82 +++++++++++++++++++++++++---------
>  arch/arm64/boot/dts/arm/juno.dts       |  5 ++-
>  2 files changed, 63 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index eb749c5..33b41ba 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -122,15 +122,18 @@
>  			port at 0 {
>  				reg = <0>;
>  				etf0_in_port: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&main_funnel_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			/* output port */
>  			port at 1 {
> -				reg = <0>;
> +				reg = <1>;
>  				etf0_out_port: endpoint {
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  		};
> @@ -145,8 +148,9 @@
>  		power-domains = <&scpi_devpd 0>;
>  		port {
>  			tpiu_in_port: endpoint {
> -				slave-mode;
> +				direction = <0>;
>  				remote-endpoint = <&replicator_out_port0>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -168,23 +172,27 @@
>  				reg = <0>;
>  				main_funnel_out_port: endpoint {
>  					remote-endpoint = <&etf0_in_port>;
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  
>  			/* input ports */
>  			port at 1 {
> -				reg = <0>;
> +				reg = <1>;
>  				main_funnel_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster0_funnel_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			port at 2 {
> -				reg = <1>;
> +				reg = <2>;
>  				main_funnel_in_port1: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_funnel_out_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  		};
> @@ -200,8 +208,9 @@
>  		power-domains = <&scpi_devpd 0>;
>  		port {
>  			etr_in_port: endpoint {
> -				slave-mode;
> +				direction = <0>;
>  				remote-endpoint = <&replicator_out_port1>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -217,6 +226,8 @@
>  		power-domains = <&scpi_devpd 0>;
>  		port {
>  			stm_out_port: endpoint {
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -240,6 +251,8 @@
>  		port {
>  			cluster0_etm0_out_port: endpoint {
>  				remote-endpoint = <&cluster0_funnel_in_port0>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -259,22 +272,26 @@
>  				reg = <0>;
>  				cluster0_funnel_out_port: endpoint {
>  					remote-endpoint = <&main_funnel_in_port0>;
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  
>  			port at 1 {
> -				reg = <0>;
> +				reg = <1>;
>  				cluster0_funnel_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster0_etm0_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			port at 2 {
> -				reg = <1>;
> +				reg = <2>;
>  				cluster0_funnel_in_port1: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster0_etm1_out_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  		};
> @@ -299,6 +316,8 @@
>  		port {
>  			cluster0_etm1_out_port: endpoint {
>  				remote-endpoint = <&cluster0_funnel_in_port1>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -322,6 +341,8 @@
>  		port {
>  			cluster1_etm0_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port0>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -341,36 +362,42 @@
>  				reg = <0>;
>  				cluster1_funnel_out_port: endpoint {
>  					remote-endpoint = <&main_funnel_in_port1>;
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  
>  			port at 1 {
> -				reg = <0>;
> +				reg = <1>;
>  				cluster1_funnel_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_etm0_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			port at 2 {
> -				reg = <1>;
> +				reg = <2>;
>  				cluster1_funnel_in_port1: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_etm1_out_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  			port at 3 {
> -				reg = <2>;
> +				reg = <3>;
>  				cluster1_funnel_in_port2: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_etm2_out_port>;
> +					coresight,hwid = <2>;
>  				};
>  			};
>  			port at 4 {
> -				reg = <3>;
> +				reg = <4>;
>  				cluster1_funnel_in_port3: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_etm3_out_port>;
> +					coresight,hwid = <3>;
>  				};
>  			};
>  		};
> @@ -395,6 +422,8 @@
>  		port {
>  			cluster1_etm1_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port1>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -418,6 +447,8 @@
>  		port {
>  			cluster1_etm2_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port2>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -441,6 +472,8 @@
>  		port {
>  			cluster1_etm3_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port3>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -462,6 +495,8 @@
>  				reg = <0>;
>  				replicator_out_port0: endpoint {
>  					remote-endpoint = <&tpiu_in_port>;
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  
> @@ -469,14 +504,17 @@
>  				reg = <1>;
>  				replicator_out_port1: endpoint {
>  					remote-endpoint = <&etr_in_port>;
> +					coresight,hwid = <1>;
> +					direction = <1>;
>  				};
>  			};
>  
>  			/* replicator input port */
>  			port at 2 {
> -				reg = <0>;
> +				reg = <2>;
>  				replicator_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index c9236c4..27b8036 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -260,10 +260,11 @@
>  &main_funnel {
>  	ports {
>  		port at 3 {
> -			reg = <2>;
> +			reg = <3>;
>  			main_funnel_in_port2: endpoint {
> -				slave-mode;
> +				direction = <0>;
>  				remote-endpoint = <&stm_out_port>;
> +				coresight,hwid = <2>;
>  			};
>  		};
>  	};
> -- 
> 2.7.4
> 
