From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 May 2013 14:34:49 +0800
Subject: [PATCH v3 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <1369389564-13181-2-git-send-email-b32955@freescale.com>
References: <1369389564-13181-1-git-send-email-b32955@freescale.com>
 <1369389564-13181-2-git-send-email-b32955@freescale.com>
Message-ID: <20130527063448.GF7782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 05:59:19PM +0800, Huang Shijie wrote:
> +Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
> +
> +	weim: weim at 021b8000 {
> +		compatible = "fsl,imx6q-weim";
> +		reg = <0x021b8000 0x4000>;
> +		clocks = <&clks 196>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0x08000000 0x08000000>;
> +
> +		nor at 0,0 {
> +			compatible = "cfi-flash";
> +			reg = <0 0 0x02000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			bank-width = <2>;
> +
Nit: remove this unneeded blank line.
> +			fsl,weim-cs-timing = <0x00620081 0x00000001 0x1C022000
> +					0x0000C000 0x1404a38e 0x00000000>;

Nit: please consistently use lower case for hex value.

Please update patch #6 as well.

Other than that,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

> +		};
> +	};
