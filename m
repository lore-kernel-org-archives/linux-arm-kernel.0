From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Sep 2016 21:05:49 +0800
Subject: [PATCH 3/7] [v2] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <1473069695-33092-4-git-send-email-shh.xie@gmail.com>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
 <1473069695-33092-4-git-send-email-shh.xie@gmail.com>
Message-ID: <20160908130549.GA16911@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 06:01:31PM +0800, shh.xie at gmail.com wrote:
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clockgen: clocking at 1ee1000 {
> +			compatible = "fsl,ls1046a-clockgen";
> +			reg = <0x0 0x1ee1000 0x0 0x1000>;
> +			#clock-cells = <2>;
> +			clocks = <&sysclk>;
> +		};
> +
> +		scfg: scfg at 1570000 {

Instead of having device node in arbitrary place, can we sort all the
nodes under 'simple-bus' in order of unit-address?

Shawn

> +			compatible = "fsl,ls1046a-scfg", "syscon";
> +			reg = <0x0 0x1570000 0x0 0x10000>;
> +			big-endian;
> +		};
