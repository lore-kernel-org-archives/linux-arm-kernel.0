From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Mon, 30 Oct 2017 15:55:15 +0000
Subject: [PATCH v10 6/9] LPC: Support the LPC host on Hip06/Hip07 with
 DT bindings
In-Reply-To: <de9f0362-6f2d-2f73-a23a-af248a9b1963@infradead.org>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
 <de9f0362-6f2d-2f73-a23a-af248a9b1963@infradead.org>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CAEE3A@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy

> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap at infradead.org]
> Sent: 27 October 2017 17:44
> To: Gabriele Paoloni; catalin.marinas at arm.com; will.deacon at arm.com;
> robh+dt at kernel.org; frowand.list at gmail.com; bhelgaas at google.com;
> rafael at kernel.org; arnd at arndb.de; linux-arm-kernel at lists.infradead.org;
> lorenzo.pieralisi at arm.com
> Cc: mark.rutland at arm.com; brian.starkey at arm.com; olof at lixom.net;
> benh at kernel.crashing.org; linux-kernel at vger.kernel.org; linux-
> acpi at vger.kernel.org; Linuxarm; linux-pci at vger.kernel.org;
> minyard at acm.org; John Garry; xuwei (O); zhichang.yuan
> Subject: Re: [PATCH v10 6/9] LPC: Support the LPC host on Hip06/Hip07
> with DT bindings
> 
> On 10/27/17 09:11, Gabriele Paoloni wrote:
> > diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> > index 2408ea3..358eed3 100644
> > --- a/drivers/bus/Kconfig
> > +++ b/drivers/bus/Kconfig
> > @@ -64,6 +64,15 @@ config BRCMSTB_GISB_ARB
> >  	  arbiter. This driver provides timeout and target abort error
> handling
> >  	  and internal bus master decoding.
> >
> > +config HISILICON_LPC
> > +	bool "Support for ISA I/O space on Hisilicon Hip0X"
> > +	depends on (ARM64 && (ARCH_HISI || COMPILE_TEST))
> > +	select LOGIC_PIO
> > +	select INDIRECT_PIO
> > +	help
> > +	  Driver needed for some legacy ISA devices attached to Low-Pin-
> Count
> > +	  on Hisilicon Hip0X SoC.
> > +
> >  config IMX_WEIM
> >  	bool "Freescale EIM DRIVER"
> >  	depends on ARCH_MXC
> 
> Hi,
> 
> Why bool? why not tristate?

Well for the nature of our HW it would not make much sense to have the
LPC modular. Also you can see in patch 8 the LPC host is "translating"
the resources of its children before these are actually probed and this
is done by acpi_indirectio_scan_init() as part of the ACPI init process.

Thanks
Gab

> 
> --
> ~Randy
