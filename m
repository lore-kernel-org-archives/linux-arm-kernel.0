From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 3 Jun 2013 07:05:50 +0200
Subject: [PATCH] ARM: Kirkwood add cpus definition needed by cpufreq
 driver to dtsi
In-Reply-To: <51ABC056.5000804@baker-net.org.uk>
References: <51ABC056.5000804@baker-net.org.uk>
Message-ID: <20130603050550.GB10843@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 10:59:50PM +0100, Adam Baker wrote:
> The Kirkwood CPU Freq driver needs a CPU definition in order for the probe
> routine to activate it. Add a suitable definition to kirkwood.dtsi
> 
> This definition is only correct for single core SoCs. There is a dual core
> SoC in the kirkwood family (88F632X) but the rest of the Kirkwood drivers in
> the kernel don't currently support it. If they ever do the cpus definition
> would need to be duplicated in each of the SoC specific include files.
> 
> Signed-off-by: Adam Baker <linux@baker-net.org.uk>

Tested-by: Andrew Lunn <andrew@lunn.ch>

	   Andrew
> 
> 
> --- a/arch/arm/boot/dts/kirkwood.dtsi	2013-05-19 22:57:07.000000000 +0100
> +++ b/arch/arm/boot/dts/kirkwood.dtsi	2013-05-30 23:32:18.000000000 +0100
> @@ -4,6 +4,18 @@
>  	compatible = "marvell,kirkwood";
>  	interrupt-parent = <&intc>;
>  
> +        cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +		      device_type = "cpu";
> +		      compatible = "marvell,feroceon";
> +		      clocks = <&core_clk 1>, <&core_clk 3>, <&gate_clk 11>;
> +		      clock-names = "cpu_clk", "ddrclk", "powersave";
> +		};
> +	};
> +
>  	aliases {
>  	       gpio0 = &gpio0;
>  	       gpio1 = &gpio1;
