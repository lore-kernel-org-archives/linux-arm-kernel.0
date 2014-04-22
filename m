From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 22 Apr 2014 01:37:15 +0000
Subject: [PATCH] ARM: dts: at91-sama5d3_xplained: add the regulator
 device node
In-Reply-To: <20140421122205.GB3461@piout.net>
References: <1398054547-5834-1-git-send-email-wenyou.yang@atmel.com>
 <20140421095443.GA3461@piout.net> <20140421122205.GB3461@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A24364180A876DA@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: Monday, April 21, 2014 8:22 PM
> To: Yang, Wenyou
> Cc: devicetree at vger.kernel.org; Ferre, Nicolas; linux-
> kernel at vger.kernel.org; robh+dt at kernel.org; broonie at kernel.org; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: dts: at91-sama5d3_xplained: add the regulator
> device node
> 
> On 21/04/2014 at 11:54:43 +0200, Alexandre Belloni wrote :
> > Hi,
> >
> > On 21/04/2014 at 12:29:07 +0800, Wenyou Yang wrote :
> > > +
> > > +						vddana_reg: LDO_REG2 {
> > > +							regulator-name = "VDDANA";
> > > +							regulator-min-microvolt =
> <3300000>;
> > > +							regulator-max-microvolt =
> <3300000>;
> > > +							regulator-always-on;
> >
> > I'm pretty sure that one is not always on as you actually have to
> > configure it to get any voltage. Are you sure you want to set the
> > regulator-always-on property here ?
> >
> 
> Just to clarify my though, wouldn't it be better to make the ADC driver
> handle that regulator instead of using regulator-always-on ?
Yes, you are right. 
It should not use regulator-always-on property for this regulator. It is ADC driver and ISI driver to handle it(The ISI takes PCK for clock).

I will send new version patch.

Thanks

> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-
> electrons.com

Best Regards,
Wenyou Yang
