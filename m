From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Jan 2018 09:28:02 +0100
Subject: [PATCH v2 16/16] ARM: dts: r8a7794: sort subnodes of root node
In-Reply-To: <20180118022000.GQ11924@bigcity.dyn.berto.se>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
 <20180117161717.14589-17-horms+renesas@verge.net.au>
 <20180118022000.GQ11924@bigcity.dyn.berto.se>
Message-ID: <20180118082802.zdnhkheaqjb5k3j5@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 03:20:00AM +0100, Niklas S?derlund wrote:
> Hi Simon,
> 
> Thanks for your patch.
> 
> On 2018-01-17 17:17:17 +0100, Simon Horman wrote:
> > Sort the subnodes of the soc node to improve maintainability.
> > The sort key is the address on the bus with instances of the same
> > IP block grouped together.
> > 
> > This patch should not introduce any functional change.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> This patch also aligns the comment for audio_clka. This is good but not 
> mentioned in the commit message which confused the review bot, i.e me :-)

Sorry, its probably worth adding that to the changelog.

> Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> 
> > ---
> > v2
> > * New patch
> > ---
> >  arch/arm/boot/dts/r8a7794.dtsi | 90 +++++++++++++++++++++---------------------
> >  1 file changed, 45 insertions(+), 45 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> > index 9e5f886f53c5..d588efa6aeaa 100644
> > --- a/arch/arm/boot/dts/r8a7794.dtsi
> > +++ b/arch/arm/boot/dts/r8a7794.dtsi
> > @@ -33,6 +33,35 @@
> >  		vin1 = &vin1;
> >  	};
> >  
> > +	/*
> > +	 * The external audio clocks are configured as 0 Hz fixed frequency
> > +	 * clocks by default.
> > +	 * Boards that provide audio clocks should override them.
> > +	 */
> > +	audio_clka: audio_clka {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <0>;
> > +	};
> > +	audio_clkb: audio_clkb {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <0>;
> > +	};
> > +	audio_clkc: audio_clkc {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <0>;
> > +	};
> > +
> > +	/* External CAN clock */
> > +	can_clk: can {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		/* This value must be overridden by the board. */
> > +		clock-frequency = <0>;
> > +	};
> > +
> >  	cpus {
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > @@ -66,6 +95,22 @@
> >  		};
> >  	};
> >  
> > +	/* External root clock */
> > +	extal_clk: extal {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		/* This value must be overridden by the board. */
> > +		clock-frequency = <0>;
> > +	};
> > +
> > +	/* External SCIF clock */
> > +	scif_clk: scif {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		/* This value must be overridden by the board. */
> > +		clock-frequency = <0>;
> > +	};
> > +
> >  	soc {
> >  		compatible = "simple-bus";
> >  		interrupt-parent = <&gic>;
> > @@ -1353,55 +1398,10 @@
> >  				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> >  	};
> >  
> > -	/* External root clock */
> > -	extal_clk: extal {
> > -		compatible = "fixed-clock";
> > -		#clock-cells = <0>;
> > -		/* This value must be overridden by the board. */
> > -		clock-frequency = <0>;
> > -	};
> > -
> >  	/* External USB clock - can be overridden by the board */
> >  	usb_extal_clk: usb_extal {
> >  		compatible = "fixed-clock";
> >  		#clock-cells = <0>;
> >  		clock-frequency = <48000000>;
> >  	};
> > -
> > -	/* External CAN clock */
> > -	can_clk: can {
> > -		compatible = "fixed-clock";
> > -		#clock-cells = <0>;
> > -		/* This value must be overridden by the board. */
> > -		clock-frequency = <0>;
> > -	};
> > -
> > -	/* External SCIF clock */
> > -	scif_clk: scif {
> > -		compatible = "fixed-clock";
> > -		#clock-cells = <0>;
> > -		/* This value must be overridden by the board. */
> > -		clock-frequency = <0>;
> > -	};
> > -
> > -	/*
> > -	 * The external audio clocks are configured  as 0 Hz fixed
> > -	 * frequency clocks by default.  Boards that provide audio
> > -	 * clocks should override them.
> > -	 */
> > -	audio_clka: audio_clka {
> > -		compatible = "fixed-clock";
> > -		#clock-cells = <0>;
> > -		clock-frequency = <0>;
> > -	};
> > -	audio_clkb: audio_clkb {
> > -		compatible = "fixed-clock";
> > -		#clock-cells = <0>;
> > -		clock-frequency = <0>;
> > -	};
> > -	audio_clkc: audio_clkc {
> > -		compatible = "fixed-clock";
> > -		#clock-cells = <0>;
> > -		clock-frequency = <0>;
> > -	};
> >  };
> > -- 
> > 2.11.0
> > 
> 
> -- 
> Regards,
> Niklas S?derlund
> 
