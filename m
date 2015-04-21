From: Dongsheng.Wang@freescale.com (Dongsheng.Wang at freescale.com)
Date: Tue, 21 Apr 2015 11:01:06 +0000
Subject: [RESEND PATCH 4/8] layerscape/ftm: Add compatible string for FTM0
 be used as alarm timer.
In-Reply-To: <20150421104228.GC8544@leverpostej>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
 <1427888858-29636-5-git-send-email-bhupesh.sharma@freescale.com>
 <20150401132400.GF11403@leverpostej>
 <BN1PR03MB1881AD322072E34DAC380259DEF0@BN1PR03MB188.namprd03.prod.outlook.com>
 <20150421104228.GC8544@leverpostej>
Message-ID: <BN1PR03MB18889FA7A501618AD29E1F79DEF0@BN1PR03MB188.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Tuesday, April 21, 2015 6:42 PM
> To: Wang Dongsheng-B40534
> Cc: Sharma Bhupesh-B45370; arnd at arndb.de; linux-arm-kernel at lists.infradead.org;
> Marc Zyngier; bhupesh.linux at gmail.com; Catalin Marinas; Yoder Stuart-B08248;
> olof at lixom.net; Will Deacon
> Subject: Re: [RESEND PATCH 4/8] layerscape/ftm: Add compatible string for FTM0
> be used as alarm timer.
> 
> > > > +	ftm0: ftm0 at 2800000 {
> > > > +		compatible = "fsl,ftm-alarm";
> > > > +		reg = <0x0 0x2800000 0x0 0x10000>;
> > > > +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> > > > +	};
> > >
> > > Missing properties?
> > >
> >
> > The FTM0 alarm timer only need "compatible", "reg" and "interrupts" properties.
> > I miss something about the properties?
> 
> As far as I could tell from the original patch, clocks were also listed as
> required properties regardless.
> 

Yes, But only one clock can be used for FTM0 as alarm timer. So this node not need to
"clock" properties. :)

Regards,
-Dongsheng
