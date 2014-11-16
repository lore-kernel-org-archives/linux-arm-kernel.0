From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 16 Nov 2014 11:32:23 -0800
Subject: [PATCH v4 6/6] ARM: zynq: DT: Add OCM controller node
In-Reply-To: <546881CA.2020801@suse.de>
References: <cover.1415962281.git.michal.simek@xilinx.com>
 <0a88d52b5e71fb220ca619180ec9ca746edad2b1.1415962281.git.michal.simek@xilinx.com>
 <546881CA.2020801@suse.de>
Message-ID: <c52187589f5c4cc6b908d899c2b9f7a6@BN1BFFO11FD036.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-11-16 at 11:51AM +0100, Andreas F?rber wrote:
> Hi Michal,
> 
> Am 14.11.2014 um 11:52 schrieb Michal Simek:
> > diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> > index ce2ef5bec4f2..e217fb1c1169 100644
> > --- a/arch/arm/boot/dts/zynq-7000.dtsi
> > +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> > @@ -150,6 +150,13 @@
> >  			reg = <0xf8006000 0x1000>;
> >  		};
> > 
> > +		ocmc: memory-controller at f800c000 {
> > +			compatible = "xlnx,zynq-ocmc-1.0";
> > +			interrupt-parent = <&intc>;
> > +			interrupts = <0 3 4>;
> > +			reg = <0xf800c000 0x1000>;
> > +		};
> > +
> >  		uart0: serial at e0000000 {
> >  			compatible = "xlnx,xuartps", "cdns,uart-r1p8";
> >  			status = "disabled";
> 
> Not directly related to this patch: As one can see here, the node order
> is quite a mess... According to Olof, nodes should be ordered by unit
> address, whereas here some but not all seem ordered by node name. Would
> you welcome a cleanup patch, or can you fix that yourself?

I wouldn't say it's a mess, just a different property to sort the nodes
by. For humans reading the DT, searching for nodes, alphabetical order
helps finding the right node, IMHO. What advantage would sorting by
address have?

	Thanks,
	S?ren
