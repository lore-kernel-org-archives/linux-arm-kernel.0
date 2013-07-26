From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 26 Jul 2013 15:44:54 -0500
Subject: [PATCH] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <51F2D5EA.7050108@wwwdotorg.org>
References: <1374789881-20611-1-git-send-email-dinguyen@altera.com>
 <51F2B0C4.8000301@wwwdotorg.org> <1374867220.20685.44.camel@linux-builds1>
 <51F2D5EA.7050108@wwwdotorg.org>
Message-ID: <1374871494.20685.46.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-07-26 at 14:02 -0600, Stephen Warren wrote:
> On 07/26/2013 01:33 PM, Dinh Nguyen wrote:
> > On Fri, 2013-07-26 at 11:24 -0600, Stephen Warren wrote:
> >> On 07/25/2013 04:04 PM, dinguyen at altera.com wrote:
> >>> From: Dinh Nguyen <dinguyen@altera.com>
> >>>
> >>> Add bindings for SD/MMC for SOCFPGA.
> >>> Add "syscon" to the "altr,sys-mgr" binding.
> 
> >>> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> >>> +Example:
> >>> +
> >>> +  The MSHC controller node can be split into two portions, SoC specific and
> >>> +  board specific portions, as listed below.
> >>
> >> That doesn't sound like a good idea. There should be one DT node for
> >> each logical block. The internal construction of the Linux drivers
> >> (presumably you have entirely separate code to handle the two nodes in
> >> Linux so far?) should not influence the DT construction at all.
> > 
> > In the end, there is only 1 DT node for each logical block:
> 
> Oh right, I see you were intending to show the distinction between the
> SoC .dtsi and board .dts file. I hadn't realized that. I don't think
> it's common to do that in the examples, so I would recommend just
> merging the whole example together myself.

I'll merge it.

> 
> > dwmmc0 at ff704000 {
> > 	compatible = "altr,socfpga-dw-mshc";
> 
> That should include the baseline synopsis compatible value too.

We don't need the baseline synopsis compatible because of
dw_mci_pltfm_register() call.

Thanks,
Dinh
> 
> > 	reg = <0xff704000 0x00001000>;
> > 	interrupts = <0x00000000 0x0000008b 0x00000004>;
> > 	fifo-depth = <0x00000400>;
> > 	#address-cells = <0x00000001>;
> > 	#size-cells = <0x00000000>;
> > 	clocks = <0x00000016 0x00000017>;
> > 	clock-names = "biu", "ciu";
> > 	num-slots = <0x00000001>;
> > 	supports-highspeed;
> > 	broken-cd;
> >  	altr,dw-mshc-ciu-div = <0x00000003>;
> >   	altr,dw-mshc-sdr-timing = <0x00000000 0x00000003>;
> > 	slot at 0 {
> > 		reg = <0x00000000>;
> > 		bus-width = <0x00000004>;
> > 		};
> > 	};
> 
> 
