From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Apr 2016 00:50:11 +0200
Subject: [PATCH V6 02/13] pci,
 acpi: Provide generic way to assign bus domain number.
In-Reply-To: <1614997.P8lXtkpXQq@wuerfel>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <20160428150815.GB15598@localhost> <1614997.P8lXtkpXQq@wuerfel>
Message-ID: <1964262.h2oIOhyNUf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2016 17:34:10 Arnd Bergmann wrote:
> On Thursday 28 April 2016 10:12:12 Bjorn Helgaas wrote:
> > Right, we don't have a good mechanism for passing more info into
> > pci_create_root_bus().  Maybe the caller could fill in a struct so we
> > have a chance to extend it without having to change all the existing
> > callers.
> > 
> > I wonder if there's a design pattern we can copy, e.g., would
> > something like the scsi_host_alloc(), scsi_add_host(),
> > scsi_scan_host() model work here?
> 
> Yes, I think that is a good idea in general. Especially
> now that we have separate the ARM code from pci_common_init_dev
> and pci_sys_data, that can help with cleanups in the other drivers
> as well.
> 
> I see two common variations in other subsystems: some use a
> special alloc() function that you pass the size of the private
> data into, while others just expect you to embed a structure
> inside of the driver specific one allocate that separately to
> have the generic registration function fill out the common fields.
> 
> I have a slight preference for the second, but they are really
> the same thing basically.

I've tried this out now, and will follow up with a separate patch
series. Overall, I think it works out well, though I haven't gotten
to the point of actually saving code yet. I've converted two
drivers for demonstration.

	Arnd
