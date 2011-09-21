From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 21 Sep 2011 15:33:10 +0100
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <20110921142425.GE2872@arm.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
	<4E79E588.6010703@gmail.com>  <20110921142425.GE2872@arm.com>
Message-ID: <1316615590.4611.624.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> OK, I'll try to propose documentation for these:
>         * arm,pl180

You can skip this one - I'll add the description together with the MMCI
driver bindings (it will be 180 and 181, by the way :-)

> > > +			// Timer init is hardcoded in v2m_timer_init(), for now.
> > > +			// timer at 11000 {
> > > +			//	compatible = "arm,arm-sp804";
> > 
> > arm,sp804 is more consistent. I believe the sp804 does have the periphid
> > registers, so arm,primecell should also be added.
> 
> Do you mean "does not have"?  If so, the periphid will be needed -- thanks for
> pointing it out in that case.

I think Rob meant it should be
	compatible = "arm,sp804", "arm,primecell",
as SP804 contains the PrimeCell periphid registers, so will be
recognized by amba bus driver.

> I will make the names consistent.  These were pasted from someone Lorenzo's
> older patches, and failed to sport e the inconsistency since I wasn't
> actually making use of these entries yet.
> 
> > > +			//	reg = <0x11000 0x1000>;
> > > +			//	interrupts = <2>;
> > > +			// };
> > > +
> > > +			// timer at 12000 {
> > > +			//	compatible = "arm,arm-sp804";
> > > +			//	reg = <0x12000 0x1000>;
> > > +			// };
> > 
> > Just because Linux is not using it, doesn't mean you should comment it out.
> 
> From the point of view of describing the hardware, yes.  However, I was
> a bit worried that if sp804 is turned into a full driver, it will get
> initialised twice -- once explicitly and once in of_platform_populate()...
> at least until the baord code is adapted to work properly with the new
> driver.
> 
> Commenting these entries out for now seemed a good idea to avoid the flag-day
> hazard.  Am I being too cautious?

I think you are ;-) Besides my static-mapping-rework is already using
those...

Cheers!

Pawe?
