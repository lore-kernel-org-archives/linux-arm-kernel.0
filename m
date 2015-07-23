From: nikhil.badola@freescale.com (Badola Nikhil)
Date: Thu, 23 Jul 2015 11:26:19 +0000
Subject: [PATCH 3/3] arm: dts: ls1021a: Add snps, configure-gfladj property
 to USB3 node
In-Reply-To: <1564365.o2o69FAsZI@ws-stein>
References: <1437646378-1910-1-git-send-email-nikhil.badola@freescale.com>
 <1564365.o2o69FAsZI@ws-stein>
Message-ID: <SN1PR0301MB16290E4A5E871BCAEC4E06FCF3820@SN1PR0301MB1629.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Alexander Stein [mailto:alexander.stein at systec-electronic.com]
> Sent: Thursday, July 23, 2015 3:41 PM
> To: Badola Nikhil-B46172
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH 3/3] arm: dts: ls1021a: Add snps,configure-gfladj
> property to USB3 node
> 
> On Thursday 23 July 2015 15:42:58, Nikhil Badola wrote:
> > Add "snps,configure-gfladj" boolean property to USB3 node. This
> > property
>                       ^^^^^^
> This does not match...
> 
> > is used to determine if frame length adjustment is required
> >
> > Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> > ---
> >  arch/arm/boot/dts/ls1021a.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi
> > b/arch/arm/boot/dts/ls1021a.dtsi index c70bb27..f03f842 100644
> > --- a/arch/arm/boot/dts/ls1021a.dtsi
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -404,6 +404,7 @@
> >  			reg = <0x0 0x3100000 0x0 0x10000>;
> >  			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
> >  			dr_mode = "host";
> > +			snps,configure-fladj = <0x20>;
>                              ^^^^^
> ...that. The same is for the subject. I guess these "gfladj" are just leftovers as
> patch 1 & 2 talk about "fladj"

Fladj stands for Frame Length ADJustment whereas the register used for this is gfladj.
Yes we intend to override fladj, hence using fladj in patch 1 and 2. I will remove gladj from 
subject and description.
Further, I will be changing the property to "snps,fladj-override" as suggested by Mark in patch 1
and send next patch version.
Please let me know if there are any other comments. 

> 
> Best regards,
> Alexander
> --
> Dipl.-Inf. Alexander Stein
> SYS TEC electronic GmbH
> alexander.stein at systec-electronic.com
> 
> Legal and Commercial Address:
> Am Windrad 2
> 08468 Heinsdorfergrund
> Germany
> 
> Office: +49 (0) 3765 38600-0
> Fax:    +49 (0) 3765 38600-4100
> 
> Managing Directors:
> 	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
> 	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
> Commercial Registry:
> 	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010
