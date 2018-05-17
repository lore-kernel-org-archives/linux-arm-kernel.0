From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 17 May 2018 18:06:32 +0200 (CEST)
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <alpine.DEB.2.21.1805171007260.7820@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net>
 <alpine.DEB.2.21.1805171007260.7820@macbook-air>
Message-ID: <385156660.62726.1526573192894@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Vince Weaver <vincent.weaver@maine.edu> hat am 17. Mai 2018 um 16:11 geschrieben:
> 
> 
> On Thu, 17 May 2018, Eric Anholt wrote:
> 
> > diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
> > index 7704bb029605..1f5e5c782835 100644
> > --- a/arch/arm/boot/dts/bcm2837.dtsi
> > +++ b/arch/arm/boot/dts/bcm2837.dtsi
> > @@ -17,6 +17,12 @@
> >  		};
> >  	};
> >  
> > +	arm-pmu {
> > +		compatible = "arm,cortex-a53-pmu", "arm,cortex-a7-pmu";
> > +		interrupt-parent = <&local_intc>;
> > +		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> 
> why this and not
> 
> arm-pmu {
> 	compatible = "arm,armv8-pmuv3";
> 	interrupt-parent = <&local_intc>;
> 	interrupts = <9>;
> };
> 
> which works, though when I didn't get very far when I submitted the patch 
> to add this last August.

Eric's variant is more specific so we better chose this. The init code diverse between the general arm,armv8-pmuv3 and arm,cortex-a53-pmu.

> 
> Vince
> 
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
