From: Mingkai.Hu@freescale.com (Hu Vincent)
Date: Wed, 25 Nov 2015 05:01:10 +0000
Subject: [PATCH] dts/ls2080a: Update PCIe compatible
In-Reply-To: <20151124202203.GA32297@rob-hp-laptop>
References: <1448345075-6801-1-git-send-email-Mingkai.Hu@freescale.com>
 <20151124202203.GA32297@rob-hp-laptop>
Message-ID: <BN3PR0301MB1249CD4A615CCD7308FB067184050@BN3PR0301MB1249.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Wednesday, November 25, 2015 4:22 AM
> To: Hu Mingkai-B21284
> Cc: arm at kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; Li Yang-Leo-R58472; Lian Minghuan-B31939
> Subject: Re: [PATCH] dts/ls2080a: Update PCIe compatible
> 
> On Tue, Nov 24, 2015 at 02:04:35PM +0800, Mingkai Hu wrote:
> > From: Minghuan Lian <Minghuan.Lian@freescale.com>
> >
> > The patch adds LS2085a to PCIe compatible to fix the compatibility
> > issue when using firmware with LS2085a compatible property.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> > ---
> >  Documentation/devicetree/bindings/pci/layerscape-pci.txt |  1 +
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi           | 12
> ++++++++----
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > index e376785..4600007 100644
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > @@ -15,6 +15,7 @@ Required properties:
> >  - compatible: should contain the platform identifier such as:
> >          "fsl,ls1021a-pcie", "snps,dw-pcie"
> >          "fsl,ls2080a-pcie", "snps,dw-pcie"
> > +        "fsl,ls2085a-pcie", "snps,dw-pcie"
> >  - reg: base addresses and lengths of the PCIe controller
> >  - interrupts: A list of interrupt outputs of the controller. Must
> contain an
> >    entry for each entry in the interrupt-names property.
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > index e81cd48..3821bb1 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> > @@ -383,7 +383,8 @@
> >  		};
> >
> >  		pcie at 3400000 {
> > -			compatible = "fsl,ls2080a-pcie", "snps,dw-pcie";
> > +			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
> > +				     "snps,dw-pcie";
> 
> This doesn't match the doc as to what are valid combinations. The order
> here seems backwards too. ls2085a is older?
> 

Yes, ls2085a was released earlier. You mean the older one comes first? Like:

compatible = "fsl,ls2085a-pcie", "fsl,ls2080a-pcie",
		 "snps,dw-pcie";

Thanks,
Mingkai
