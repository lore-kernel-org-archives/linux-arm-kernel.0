From: mporter@linaro.org (Matt Porter)
Date: Fri, 13 Dec 2013 09:40:12 -0500
Subject: [PATCH v2 6/6] ARM: brcmstb: dts: add a reference DTS for
 Broadcom 7445
In-Reply-To: <1385511748-27869-7-git-send-email-marc.ceeeee@gmail.com>
References: <1385511748-27869-1-git-send-email-marc.ceeeee@gmail.com>
 <1385511748-27869-7-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <20131213144012.GC23499@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 04:22:28PM -0800, Marc Carino wrote:
> Add a sample DTS which will allow bootup of a board populated
> with the BCM7445 chip.
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/brcmstb-7445.dts |  115 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 115 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/brcmstb-7445.dts
> 
> diff --git a/arch/arm/boot/dts/brcmstb-7445.dts b/arch/arm/boot/dts/brcmstb-7445.dts
> new file mode 100644
> index 0000000..a8b74c5
> --- /dev/null
> +++ b/arch/arm/boot/dts/brcmstb-7445.dts
> @@ -0,0 +1,115 @@
> +/dts-v1/;
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	#address-cells = <0x1>;
> +	#size-cells = <0x1>;
> +	model = "Broadcom STB (7445)";
> +	compatible = "brcm,brcmstb";
> +	interrupt-parent = <&gic>;
> +
> +	chosen {
> +		bootargs = "earlyprintk console=ttyS0,115200";
> +	};
> +
> +	memory {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x1>;
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x40000000 0x40000000 0x80000000 0x40000000>;
> +	};
> +
> +	cpupll: cpupll at 0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0x0>;
> +		clock-frequency = <1500000000>;
> +	};
> +
> +	cpuclk: cpu-clk-div at 0 {
> +		compatible = "brcm,brcmstb-cpu-clk-div";
> +		reg = <0xf03e257c 0x4>;
> +		#clock-cells = <0x0>;
> +		clocks = <&cpupll>;
> +		div-table = <0x0 0x1 0x11 0x2 0x12 0x4 0x13 0x8 0x14 0x10>;
> +	};

There's no clk driver code to use this that I can find and no binding to
describe the use of this compatible string. This node should be removed
and submitted along with the clk binding and driver series.

-Matt
