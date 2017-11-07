From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 7 Nov 2017 10:50:35 +0000
Subject: [PATCH v10 2/9] PCI: remove unused __weak attribute in
 pci_register_io_range()
In-Reply-To: <20171107002325.GC9538@bhelgaas-glaptop.roam.corp.google.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-3-git-send-email-gabriele.paoloni@huawei.com>
 <20171107002325.GC9538@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CC3351@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: 07 November 2017 00:23
> To: Gabriele Paoloni
> Cc: catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> frowand.list at gmail.com; bhelgaas at google.com; rafael at kernel.org;
> arnd at arndb.de; linux-arm-kernel at lists.infradead.org;
> lorenzo.pieralisi at arm.com; mark.rutland at arm.com; brian.starkey at arm.com;
> olof at lixom.net; benh at kernel.crashing.org; linux-kernel at vger.kernel.org;
> linux-acpi at vger.kernel.org; Linuxarm; linux-pci at vger.kernel.org;
> minyard at acm.org; John Garry; xuwei (O)
> Subject: Re: [PATCH v10 2/9] PCI: remove unused __weak attribute in
> pci_register_io_range()
> 
> > PCI: remove unused __weak attribute in pci_register_io_range()
> 
> Please capitalize to follow drivers/pci convention, e.g.,
> 
>   PCI: Remove __weak attribute from pci_register_io_range()
> 
> (Also do the same for the other PCI patches.)

Agreed, many thanks

Gab

> 
> On Fri, Oct 27, 2017 at 05:11:20PM +0100, Gabriele Paoloni wrote:
> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> >
> > Currently pci_register_io_range() has only one definition;
> > therefore there is no use of the __weak attribute.
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Acked-by: Bjorn Helgaas <helgaas@kernel.org>
> > ---
> >  drivers/pci/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index af0cc34..eee967c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3270,7 +3270,7 @@ static DEFINE_SPINLOCK(io_range_lock);
> >   * Record the PCI IO range (expressed as CPU physical address +
> size).
> >   * Return a negative value if an error has occured, zero otherwise
> >   */
> > -int __weak pci_register_io_range(phys_addr_t addr, resource_size_t
> size)
> > +int pci_register_io_range(phys_addr_t addr, resource_size_t size)
> >  {
> >  	int err = 0;
> >
> > --
> > 2.7.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
