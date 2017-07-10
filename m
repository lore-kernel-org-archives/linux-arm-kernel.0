From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Jul 2017 09:13:42 -0500
Subject: [PATCH v3 3/4] dt-bindings: Document MIPS Broadcom STB power
 management nodes
In-Reply-To: <20170706222225.9758-4-f.fainelli@gmail.com>
References: <20170706222225.9758-1-f.fainelli@gmail.com>
 <20170706222225.9758-4-f.fainelli@gmail.com>
Message-ID: <20170710141342.fghqil4px5ylj336@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 03:22:24PM -0700, Florian Fainelli wrote:
> Document the different nodes required for supporting S2/S3/S5 suspend
> states on MIPS-based Broadcom STB SoCs.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/mips/brcm/soc.txt          | 153 +++++++++++++++++++++
>  1 file changed, 153 insertions(+)

A couple of nits on the node names, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> +Example:
> +
> +	memory-controller: memc at 0 {

memory-controller at 0

> +		compatible = "brcm,brcmstb-memc", "simple-bus";
> +		ranges = <0x0 0x0 0xa000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		memc-arb at 1000 {
> +			...
> +		};
> +
> +		memc-ddr at 2000 {
> +			...
> +		};
> +
> +		ddr-phy at 6000 {
> +			...
> +		};
> +	};


> +Example:
> +
> +	timers: timers at 4067c0 {

timer at ...

> +		compatible = "brcm,bcm7425-timers", "brcm,brcmstb-timers";
> +		reg = <0x4067c0 0x40>;
> +		interrupts = <&periph_intc 19>;
> +	};
> -- 
> 2.9.3
> 
