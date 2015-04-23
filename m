From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Apr 2015 10:20:33 +0100
Subject: [PATCH] coresight: Add support for Juno platform
In-Reply-To: <1429742802-13089-1-git-send-email-mathieu.poirier@linaro.org>
References: <1429742802-13089-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20150423092032.GA16238@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthieu,

> +	main_funnel at 20040000 {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0 0x20040000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				main_funnel_out_port: endpoint {
> +					remote-endpoint =
> +						<&etf_in_port>;
> +				};
> +			};
> +
> +			port at 1 {
> +				reg = <0>;
> +				main_funnel_in_port0: endpoint {
> +					slave-mode;
> +					remote-endpoint =
> +							<&A57_funnel_out_port>;
> +				};
> +			};
> +
> +			port at 2 {
> +				reg = <1>;
> +				main_funnel_in_port1: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&A53_etm0_out_port>;
> +				};
> +			};

What's going on with these reg properties? They aren't matched with
their nodes' unit-addresses, and the same reg is reused by multiple
nodes. That doesn't make sense to me.

Is the mismatch deliberate (against DT conventions), or is this
mistaken?

Likewise for the other funnels.

Mark
