From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 21:40:42 +0100
Subject: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and its
 related head file
In-Reply-To: <52A084EB.5010103@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312050438.05117.arnd@arndb.de> <52A084EB.5010103@linaro.org>
Message-ID: <201312052140.42269.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 December 2013, Hanjun Guo wrote:
> On 2013?12?05? 11:38, Arnd Bergmann wrote:
> > On Tuesday 03 December 2013, Hanjun Guo wrote:
> >> +static unsigned int gsi_to_irq(unsigned int gsi)
> >> +{
> >> +       int irq = irq_create_mapping(NULL, gsi);
> >> +
> >> +       return irq;
> >> +}
> > I think this could use a comment regarding your plans for IRQ domains.
> >
> > Do you expect that all ACPI systems would have only a single GIC IRQ
> > controller and a single domain, or do you plan to add irqdomain code
> > later?
> 
> we added irqdomain code in the part2 patch set, is that the code ok
> with you?

I don't see where it gets added. Do you mean "[RFC part2 PATCH 8/9] ACPI /
ARM64: Update acpi_register_gsi to register with the core IRQ subsystem"?
That still just uses a single domain.

When we talked about ACPI support at Linaro connect, someone mentioned
that the ACPI spec does have the concept of IRQ domains, but it seems
they are not implemented by Linux.

How do you get a mapping for an IRQ on a secondary irqchip such as
a GPIO extender?

	Arnd
