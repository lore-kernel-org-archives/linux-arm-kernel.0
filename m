From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 16:03:57 +0800
Subject: [PATCH] arm64: dts: ls1088a: Add USB support
In-Reply-To: <VI1PR04MB1262662395B8CD06BAF074CFE9800@VI1PR04MB1262.eurprd04.prod.outlook.com>
References: <1502938358-23522-1-git-send-email-yinbo.zhu@nxp.com>
 <20170817140232.GE7608@dragon>
 <VI1PR04MB1262662395B8CD06BAF074CFE9800@VI1PR04MB1262.eurprd04.prod.outlook.com>
Message-ID: <20170818080355.GK7608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 07:48:19AM +0000, Yinbo Zhu wrote:
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > index 3a3be87..0dbff29 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > @@ -458,6 +458,24 @@
> >  			status = "disabled";
> >  		};
> >  
> > +		usb0: usb3 at 3100000 {
> > +			compatible = "snps,dwc3";
> > +			reg = <0x0 0x3100000 0x0 0x10000>;
> > +			interrupts = <0 80 0x4>; /* Level high type */
> 
> Use IRQ_TYPE_LEVEL_HIGH, so that you can save the comment.
> 
> > +			dr_mode = "host";
> > +			configure-gfladj;
> 
> What is this?  I do not see it in upstream kernel.
> 
> > +			snps,dis_rxdet_inp3_quirk;
> 
> You probably need a "disabled" status.
> 
> Shawn
> 
> Hi Shawn,
> 
>  About your description " You probably need a "disabled" status."
>  Your meaning is that remove the property "snps,dis_rxdet_inp3_quirk;", isn't it?
>  In fact, if remove the property , 1088ardb usb will doesn't detect.

No, that's not what I meant.  I meant the USB device should be disabled
by default in <soc>.dtsi by having the following line.

	status = "disabled";

And then if your board has the pin-out of this USB device, you have the
line below to turn on the support.

	status = "okay";

Shawn
