From: zhiqiang.hou@nxp.com (Zhiqiang Hou)
Date: Tue, 1 Mar 2016 02:42:02 +0000
Subject: [PATCH v2 2/2] ARM64: dts: add LS1043a-QDS board support
In-Reply-To: <20160228023818.GB22051@tiger>
References: <1450948298-33238-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <1450948298-33238-2-git-send-email-Zhiqiang.Hou@freescale.com>
 <20160219032830.GG6756@tiger>
 <HE1PR04MB0906707F686591B374AA364F84A00@HE1PR04MB0906.eurprd04.prod.outlook.com>
 <20160228023818.GB22051@tiger>
Message-ID: <AM4PR04MB2148867ED34556A79AC0EB1584BB0@AM4PR04MB2148.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Thanks for your advice!

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2016?2?28? 10:38
> To: Zhiqiang Hou <zhiqiang.hou@nxp.com>
> Cc: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>; mark.rutland at arm.com;
> devicetree at vger.kernel.org; Shaohui.Xie at freescale.com; pawel.moll at arm.com;
> ijc+devicetree at hellion.org.uk; catalin.marinas at arm.com; will.deacon at arm.com;
> robh+dt at kernel.org; galak at codeaurora.org; scottwood at freescale.com;
> Mingkai.Hu at freescale.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 2/2] ARM64: dts: add LS1043a-QDS board support
> 
> On Fri, Feb 19, 2016 at 10:10:04AM +0000, Zhiqiang Hou wrote:
> 
> <snip>
> 
> > > > +	pca9547 at 77 {
> > > > +		compatible = "philips,pca9547";
> > >
> > > I cannot find this compatible string in either binding docs or driver code.
> > >
> >
> > See the file below.
> > ./drivers/i2c/muxes/i2c-mux-pca954x.c:115:	{ "pca9547", pca_9547 },
> > Perhaps the vender name should be updated to nxp.
> 
> Yes, if you look at Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt,
> "nxp,pca9547" is the one you should use here.
> 
> <snip>
> 
> > > > +			eeprom at 56 {
> > > > +				compatible = "at24,24c512";
> > >
> > > Unsupported/undocumented compatible?
> >
> > Will change it to "atmel, 24c512".
> 
> Yes, but without the space in the middle.
> 
> >
> > >
> > > > +				reg = <0x56>;
> > > > +			};
> > > > +
> > > > +			eeprom at 57 {
> > > > +				compatible = "at24,24c512";
> > > > +				reg = <0x57>;
> > > > +			};
> > > > +
> > > > +			adt7461a at 4c {
> > >
> > > temp-sensor should be a better node name, if I understand the device correctly.
> > >
> >
> > I didn't find a reference in kernel, so what name should be better, do you have
> any advice?
> 
> "temp-sensor" is what I see from the example in
> Documentation/devicetree/bindings/hwmon/lm90.txt.
> 

Thanks,
Zhiqiang
