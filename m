From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Apr 2018 11:22:35 +0200
Subject: [PATCH 2/2] arm64: dts: renesas: condor: add eMMC support
In-Reply-To: <d3cc9e96-2351-348e-9577-f0fadfd0d6c9@cogentembedded.com>
References: <611daf1f-42a2-d463-0814-ebf762871018@cogentembedded.com>
 <309b5211-bab6-53de-b8a8-6e1049e1705e@cogentembedded.com>
 <20180420100313.4cmngxeibpc2r3h2@verge.net.au>
 <d3cc9e96-2351-348e-9577-f0fadfd0d6c9@cogentembedded.com>
Message-ID: <20180424092235.hnvbqe5xs6vp7fye@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 09:51:06PM +0300, Sergei Shtylyov wrote:
> On 04/20/2018 01:03 PM, Simon Horman wrote:
> 
> >> Define the Condor board dependent part of the MMC0 (connected to eMMC chip)
> >> device node along with the necessary voltage regulators...
> >>
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >> ---
> >>  arch/arm64/boot/dts/renesas/r8a77980-condor.dts |   43 ++++++++++++++++++++++++
> >>  1 file changed, 43 insertions(+)
> >>
> >> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> >> ===================================================================
> >> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> >> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> >> @@ -27,6 +27,24 @@
> >>  		/* first 128MB is reserved for secure area. */
> >>  		reg = <0 0x48000000 0 0x78000000>;
> >>  	};
> >> +
> >> +	d3_3v: regulator-0 {
> > 
> > Please use reg_3p3v: regulator1 for consistency with salvator-common.dtsi
> 
>    Hm, not sure why I have to copy what I consider a bad example... the SoCs are
> not pin compatible anyway. 
> 
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "D3.3V";
> > 
> > And "fixed-3.3V"
> 
>    Ugh. That's pretty poor name I think. My names do correspond to the schematics
> and these only muddle things up, I think...
> 
> [...]
> >> @@ -70,6 +101,18 @@
> >>  		function = "avb";
> >>  	};
> >>  
> >> +	mmc_1_8v_pins: mmc_1_8v {
> >> +		groups = "mmc_data8", "mmc_ctrl", "mmc_ds";
> >> +		function = "mmc";
> >> +		power-source = <1800>;
> >> +	};
> >> +
> >> +	mmc_3_3v_pins: mmc_3_3v {
> >> +		groups = "mmc_data8", "mmc_ctrl", "mmc_ds";
> >> +		function = "mmc";
> >> +		power-source = <3300>;
> >> +	};
> > 
> > Again please make this more consistent with salvator-common.dtsi.
> 
>    Ah, you mean the _uhs label name postfix? OK...

Thanks, could you send a v2?
