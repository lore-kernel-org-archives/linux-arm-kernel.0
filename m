From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 03 Feb 2015 15:55:05 +0100
Subject: [PATCH v8 06/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
In-Reply-To: <54D0CD58.2000609@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <20150203121546.GD3677@e104818-lin.cambridge.arm.com>
 <54D0CD58.2000609@linaro.org>
Message-ID: <2157836.CgDKH4QWp1@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 03, 2015 09:30:00 PM Hanjun Guo wrote:
> On 2015?02?03? 20:15, Catalin Marinas wrote:
> > On Mon, Feb 02, 2015 at 12:45:34PM +0000, Hanjun Guo wrote:
> >> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> >> index ce5836c..c17e7ea 100644
> >> --- a/arch/arm64/kernel/pci.c
> >> +++ b/arch/arm64/kernel/pci.c
> >> @@ -10,6 +10,7 @@
> >>    *
> >>    */
> >>
> >> +#include <linux/acpi.h>
> >>   #include <linux/init.h>
> >>   #include <linux/io.h>
> >>   #include <linux/kernel.h>
> >> @@ -68,3 +69,27 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> >>   	bus->domain_nr = domain;
> >>   }
> >>   #endif
> >> +
> >> +/*
> >> + * raw_pci_read/write - Platform-specific PCI config space access.
> >> + */
> >> +int raw_pci_read(unsigned int domain, unsigned int bus,
> >> +		  unsigned int devfn, int reg, int len, u32 *val)
> >> +{
> >> +	return -EINVAL;
> >> +}
> >> +
> >> +int raw_pci_write(unsigned int domain, unsigned int bus,
> >> +		unsigned int devfn, int reg, int len, u32 val)
> >> +{
> >> +	return -EINVAL;
> >> +}
> >
> > You said you'll make these return -ENOSYS, which I think makes more
> > sense.
> 
> I'm sorry, I missed that, my bad, I will fix that in next version.

Actually, -ENOSYS *specifically* means "not implemented system call".
It should not be used for anything other than that.  -ENXIO is what
should be used instead.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
