From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Wed, 25 Jan 2017 10:30:00 +0000
Subject: [RFC 2/4] irqchip, gicv3-its:Workaround for HiSilicon erratum
 161010801
In-Reply-To: <20170124141505.GD7572@leverpostej>
References: <5886262C.6070108@huawei.com> <58875B0D.4080303@huawei.com>
 <20170124141505.GD7572@leverpostej>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8174ACF59@lhreml504-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Tuesday, January 24, 2017 2:15 PM
> To: Shameerali Kolothum Thodi
> Cc: marc.zyngier at arm.com; will.deacon at arm.com; linux-arm-
> kernel at lists.infradead.org; Linuxarm; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; John Garry; Guohanjun (Hanjun Guo);
> robin.murphy at arm.com
> Subject: Re: [RFC 2/4] irqchip, gicv3-its:Workaround for HiSilicon
> erratum 161010801
sounds like this will have severe implications for virtualization.
> 
> > Also these platforms doesn't have a proper IIDR
> > register to use the existing IIDR based quirk mechanism.
> 
> What exactly is wrong with the IIDR on these platforms? That sounds
> like
> an erratum as of itself.
> 
> What precise value do reads of the IIDR return? Or do reads result in
> other erroneous behaviour?

As far as I know, there is no erroneous behavior while reading.  But the
IIDR JEP106 identity code is 0 on these platforms, hence not much of use.

This will be corrected in next revision of hw.

Thanks,
Shameer
