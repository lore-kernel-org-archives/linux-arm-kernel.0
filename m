From: arnab.basu@freescale.com (arnab.basu at freescale.com)
Date: Fri, 15 Aug 2014 15:21:24 +0000
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <20140815102329.GB596@leverpostej>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140815102329.GB596@leverpostej>
Message-ID: <c43739ed82a34f6eb2adbbe240e07c5d@DM2PR03MB317.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Friday, August 15, 2014 3:54 PM
> To: Sharma Bhupesh-B45370
> Cc: devicetree-discuss at lists.ozlabs.org; Catalin Marinas; arnd at arndb.de;
> Will Deacon; Yoder Stuart-B08248; grant.likely at secretlab.ca; Basu Arnab-
> B45036; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
> 
> Hi,
> 
> On Fri, Aug 15, 2014 at 10:49:13AM +0100, Bhupesh Sharma wrote:
> > This patch adds the device tree support for FSL LS2085A SoC based on
> > ARMv8 architecture.
> >
> > Following levels of DTSI/DTS files have been created for the LS2085A
> > SoC family:
> >
> > - fsl-ls2085a.dtsi:
> > DTS-Include file for FSL LS2085A SoC.
> >
> > - fsl-ls2085a-simu.dts:
> > DTS file for FSL LS2085a software simulator model.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> > Signed-off-by: Arnab Basu <arnab.basu@freescale.com>
> > Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> > ---
> >  arch/arm64/boot/dts/fsl-ls2085a-simu.dts |   29 ++++++
> >  arch/arm64/boot/dts/fsl-ls2085a.dtsi     |  145
> ++++++++++++++++++++++++++++++
> >  2 files changed, 174 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
> >  create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi

[...]

> > diff --git a/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> > b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> > new file mode 100644
> > index 0000000..aca48ac
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> > @@ -0,0 +1,145 @@
> > +/*

[...]

> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		/* We have 4 clusters having 2 Cortex-A57 cores each */
> > +		cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57";
> > +			reg = <0x0 0x0>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0x0 0x8000fff8>;
> > +		};
> 
> I would strongly recommend having a unique cpu-release-addr for each CPU.
>

This is more of a place holder, we intend to patch this address from U-Boot
and use individual release addresses for each CPU.

Thanks
Arnab
 
> [...]
> 
> > +	serial0: serial at 21c4500 {
> > +		device_type = "serial";
> > +		compatible = "fsl,ns16550", "ns16550a";
> > +		reg = <0x0 0x21c4500 0x0 0x100>;
> > +		clock-frequency = <0>;
> 
> Do we expect this to be filled in by the bootloader?
> 
> [...]
> 
> > > +	fsl_mc: fsl-mc at 80c000000 {
> > +		compatible = "fsl,qoriq-mc";
> > +		reg = <0x00000008 0x0c000000 0 0x40	/* MC portal base */
> > +		       0x00000000 0x08340000 0 0x40000 >; /* MC control reg
> */
> 
> Nit: please bracket these individually as with other reg entries.
> 
> Thanks,
> Mark.
