From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 Nov 2017 10:51:13 +0100
Subject: [PATCH 2/2] arm64: dts: renesas: v3msk: add EtherAVB support
In-Reply-To: <20171124210317.285946395@cogentembedded.com>
References: <20171124210317.285946395@cogentembedded.com>
Message-ID: <20171129095113.ca4vc3ppbzs3plwq@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 11:59:45PM +0300, Sergei Shtylyov wrote:
> Define the V3M Starter Kit board dependent part of the EtherAVB
> device node.
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts |   11 +++++++++++
>  1 file changed, 11 insertions(+)

For consistency with other Renesas boards please consider reposing with the
following added to the chosen node.

		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";

> 
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
> @@ -31,6 +31,17 @@
>  	};
>  };
>  
> +&avb {
> +	renesas,no-ether-link;
> +	phy-handle = <&phy0>;
> +	status = "okay";
> +
> +	phy0: ethernet-phy at 0 {
> +		rxc-skew-ps = <1500>;
> +		reg = <0>;
> +	};
> +};
> +
>  &extal_clk {
>  	clock-frequency = <16666666>;
>  };
> 
