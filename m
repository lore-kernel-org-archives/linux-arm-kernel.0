From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Aug 2014 17:12:46 +0100
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <3b8cefe8260e444da5174d1b0d60b073@BY2PR0301MB0743.namprd03.prod.outlook.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140815102329.GB596@leverpostej>
 <3b8cefe8260e444da5174d1b0d60b073@BY2PR0301MB0743.namprd03.prod.outlook.com>
Message-ID: <20140815161246.GB21908@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart,

On Fri, Aug 15, 2014 at 04:37:06PM +0100, Stuart Yoder wrote:
> > > +/ {
> > > +	compatible = "fsl,ls2085a";
> > > +	interrupt-parent = <&gic>;
> > > +	#address-cells = <2>;
> > > +	#size-cells = <2>;
> > > +
> > > +	cpus {
> > > +		#address-cells = <2>;
> > > +		#size-cells = <0>;
> > > +
> > > +		/* We have 4 clusters having 2 Cortex-A57 cores each */
> > > +		cpu at 0 {
> > > +			device_type = "cpu";
> > > +			compatible = "arm,cortex-a57";
> > > +			reg = <0x0 0x0>;
> > > +			enable-method = "spin-table";
> > > +			cpu-release-addr = <0x0 0x8000fff8>;
> > > +		};
> > 
> > I would strongly recommend having a unique cpu-release-addr for each
> > CPU.
> 
> We could do that, but we were just following existing practice in
> existing arch/arm64 device trees.  The 3 existing platforms upstream
> right now all have have the same cpu-release-addr value:
>    apm-storm.dtsi
>    foundation-v8.dts
>    rtsm_ve-aemv8a.dts

In general, following existing examples is a good idea. I'm not faulting
you for that.

Unfortunately there are plenty of bad examples in DTS in the kernel.

W.R.T. unique addresses for spin-table this is something we learnt after
those dts files were upstreamed. It's not possible to change those dts
files in the kernel without breaking older firmwares/bootwrappers which
don't patch the DTB.

Cheers,
Mark.
