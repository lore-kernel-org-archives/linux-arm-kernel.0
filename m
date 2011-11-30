From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Nov 2011 13:38:11 +0000
Subject: [PATCH v3 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <201111301334.40372.arnd@arndb.de>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <201111292119.11554.arnd@arndb.de>
 <1322653600.3164.153.camel@hornet.cambridge.arm.com>
 <201111301334.40372.arnd@arndb.de>
Message-ID: <1322660291.10583.2.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 13:34 +0000, Arnd Bergmann wrote:
> On Wednesday 30 November 2011, Pawel Moll wrote:
> > 
> > On Tue, 2011-11-29 at 21:19 +0000, Arnd Bergmann wrote:
> > > On Tuesday 29 November 2011, Pawel Moll wrote:
> > > > +                       compact-flash at 1a000 {
> > > > +                               compatible = "ata-generic";
> > > > +                               reg = <0x1a000 0x100
> > > > +                                      0x1a100 0xf00>;
> > > > +                               reg-shift = <2>;
> > > > +                       };
> > > 
> > > Shouldn't there also be a more specific "compatible" value, in case we have
> > > to detect this CF slot for some reason?
> > 
> > It was the compatible-value-of-choice in
> > "drivers/ata/pata_of_platform.c", unfortunately undocumented - as I have
> > just realized - in the "Documentation/devicetree/bindings"...
> 
> You should certainly *also* have "ata-generic" in there as the value
> that is used by the existing driver, but it usually makes sense to have
> a more specific value in addition, just as a precaution for the future,
> in case that the specific hardware is not entirely identical to all others
> and we have to do a separate workaround.

Ok, as the actual "interface hardware" is a custom design for VE, I'll
make it:

	compatible = "arm,vexpress-cf", "ata-generic";

Does it make sense?

Cheers!

Pawe?
