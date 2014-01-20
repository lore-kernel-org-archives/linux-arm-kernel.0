From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 20 Jan 2014 14:36:25 +0000
Subject: [RFC part2 PATCH 8/9] ACPI / ARM64: Update acpi_register_gsi to
 register with the core IRQ subsystem
In-Reply-To: <201312110623.04341.arnd@arndb.de>
References: <1385999094-3152-1-git-send-email-hanjun.guo@linaro.org> <
 1385999094-3152-9-git-send-email-hanjun.guo@linaro.org> <20131210130521.
 3FE89C40A27@trevor.secretlab.ca> <201312110623.04341.arnd@arndb.de>
Message-ID: <20140120143625.EB0E2C40B12@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Dec 2013 06:23:04 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 10 December 2013, Grant Likely wrote:
> > > --- a/drivers/acpi/plat/arm-core.c
> > > +++ b/drivers/acpi/plat/arm-core.c
> > > @@ -90,7 +90,7 @@ enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
> > >  
> > >  static unsigned int gsi_to_irq(unsigned int gsi)
> > >  {
> > > -     int irq = irq_create_mapping(NULL, gsi);
> > > +     int irq = irq_find_mapping(NULL, gsi);
> > 
> > I suspect this will break FDT users that depend on the old behaviour.
> 
> I think not, given this is only in drivers/acpi and gets added in one
> of the prior patches of the same series.

Ah, okay.

g.
