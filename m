From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Apr 2015 12:22:09 +0100
Subject: [RESEND PATCH 4/8] layerscape/ftm: Add compatible string for
 FTM0 be used as alarm timer.
In-Reply-To: <BN1PR03MB18889FA7A501618AD29E1F79DEF0@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
 <1427888858-29636-5-git-send-email-bhupesh.sharma@freescale.com>
 <20150401132400.GF11403@leverpostej>
 <BN1PR03MB1881AD322072E34DAC380259DEF0@BN1PR03MB188.namprd03.prod.outlook.com>
 <20150421104228.GC8544@leverpostej>
 <BN1PR03MB18889FA7A501618AD29E1F79DEF0@BN1PR03MB188.namprd03.prod.outlook.com>
Message-ID: <20150421112047.GD8544@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 12:01:06PM +0100, Dongsheng.Wang at freescale.com wrote:
> 
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > Sent: Tuesday, April 21, 2015 6:42 PM
> > To: Wang Dongsheng-B40534
> > Cc: Sharma Bhupesh-B45370; arnd at arndb.de; linux-arm-kernel at lists.infradead.org;
> > Marc Zyngier; bhupesh.linux at gmail.com; Catalin Marinas; Yoder Stuart-B08248;
> > olof at lixom.net; Will Deacon
> > Subject: Re: [RESEND PATCH 4/8] layerscape/ftm: Add compatible string for FTM0
> > be used as alarm timer.
> > 
> > > > > +	ftm0: ftm0 at 2800000 {
> > > > > +		compatible = "fsl,ftm-alarm";
> > > > > +		reg = <0x0 0x2800000 0x0 0x10000>;
> > > > > +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +	};
> > > >
> > > > Missing properties?
> > > >
> > >
> > > The FTM0 alarm timer only need "compatible", "reg" and "interrupts" properties.
> > > I miss something about the properties?
> > 
> > As far as I could tell from the original patch, clocks were also listed as
> > required properties regardless.
> > 
> 
> Yes, But only one clock can be used for FTM0 as alarm timer. So this node not need to
> "clock" properties. :)

If the clock property is not necessary in some cases, please add those
caveats in the clock property description.

I'm not sure I follow why you don't need a clock in this case. Is there
a clock internal to the unit? Or is it simply that there is only one
possible external clock? For the latter it should still be described
explicitly.

Mark.
