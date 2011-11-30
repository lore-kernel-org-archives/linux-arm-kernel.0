From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2011 13:34:40 +0000
Subject: [PATCH v3 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1322653600.3164.153.camel@hornet.cambridge.arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <201111292119.11554.arnd@arndb.de>
 <1322653600.3164.153.camel@hornet.cambridge.arm.com>
Message-ID: <201111301334.40372.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 November 2011, Pawel Moll wrote:
> 
> On Tue, 2011-11-29 at 21:19 +0000, Arnd Bergmann wrote:
> > On Tuesday 29 November 2011, Pawel Moll wrote:
> > > +                       compact-flash at 1a000 {
> > > +                               compatible = "ata-generic";
> > > +                               reg = <0x1a000 0x100
> > > +                                      0x1a100 0xf00>;
> > > +                               reg-shift = <2>;
> > > +                       };
> > 
> > Shouldn't there also be a more specific "compatible" value, in case we have
> > to detect this CF slot for some reason?
> 
> It was the compatible-value-of-choice in
> "drivers/ata/pata_of_platform.c", unfortunately undocumented - as I have
> just realized - in the "Documentation/devicetree/bindings"...

You should certainly *also* have "ata-generic" in there as the value
that is used by the existing driver, but it usually makes sense to have
a more specific value in addition, just as a precaution for the future,
in case that the specific hardware is not entirely identical to all others
and we have to do a separate workaround.

> > Is there actually no interrupt?
> 
> No, polling mode only. And yes, it works ;-)

Fascinating

	Arnd
