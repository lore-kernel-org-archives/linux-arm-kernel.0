From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 16 Aug 2011 11:48:27 +0800
Subject: [RFC PATCH v2 06/13] docs/dt: Document nvidia,tegra20-pinmux
	binding
In-Reply-To: <1313440100-17131-7-git-send-email-swarren@nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<1313440100-17131-7-git-send-email-swarren@nvidia.com>
Message-ID: <20110816034827.GH8044@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 02:28:13PM -0600, Stephen Warren wrote:
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  .../devicetree/bindings/pinmux/pinmux_nvidia.txt   |  294 ++++++++++++++++++++
>  1 files changed, 294 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt
> 
[...]
> +
> +Example of a gpio-controller node:
> +

You meant pinmux node instead of gpio.

Regards,
Shawn

> +	pinmux: pinmux at 70000000 {
> +		compatible = "nvidia,tegra20-pinmux";
> +		reg = < 0x70000000 0xc00 >;
> +		nvidia,mux-groups {
> +			cdev1 {
> +				nvidia,function = "plla_out";
> +			};
> +			cdev2 {
> +				nvidia,function = "pllp_out4";
> +				nvidia,pull-down;
> +				nvidia,tristate;
> +			};
> +		};
> +		nvidia,drive-groups {
> +			sdio1 {
> +				nvidia,schmitt;
> +				nvidia,drive-power = <1>;
> +				nvidia,pull-down-strength = <31>;
> +				nvidia,pull-up-strength = <31>;
> +				nvidia,slew-rate-rising = <3>;
> +				nvidia,slew-rate-falling = <3>;
> +			};
> +		};
> +	};
> +
> -- 
> 1.7.0.4
> 
> 
