From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 19 Jan 2016 12:23:17 +0000
Subject: [PATCH v2 12/16] ARM: Xen: Document UEFI support on Xen ARM
 virtual platforms
In-Reply-To: <20160119104747.GB25024@leverpostej>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-13-git-send-email-zhaoshenglong@huawei.com>
 <20160118105115.GD21067@leverpostej>
 <alpine.DEB.2.02.1601181710270.9400@kaball.uk.xensource.com>
 <569E0F15.8090001@huawei.com> <20160119104747.GB25024@leverpostej>
Message-ID: <alpine.DEB.2.02.1601191217190.9400@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jan 2016, Mark Rutland wrote:
> On Tue, Jan 19, 2016 at 06:25:25PM +0800, Shannon Zhao wrote:
> > >> We don't do this in Documentation/arm/uefi.txt, and I don't see why we
> > >> should do so here.
> > >>
> > >> Does Xen handle arbitrary size memory map descriptors? I'm not sure what
> > >> new information might be passed in future additions to the descriptor
> > >> format, and I'm not sure what should happen in the Dom0 case.
> > > 
> > > Xen passes to Dom0 the memory map in the same format as the native
> > > memory map.
> 
> Does Xen parse or modify the EFI memory map in any way?

Xen:
- calls EFI_BOOT_SERVICES.GetMemoryMap()
- takes note of the memory regions for its own usage
- create the fdt notes, including efi-mmap-start, with a pointer to it


> Does it pass the raw values returned by EFI_BOOT_SERVICES.GetMemoryMap()
> through to the xen,uefi-* properties, or does is make any static
> assumptions about what the values will be?

It just passes the raw values.


> I'm trying to get a feeling for what the behaviour will be if/when a
> version of the EFI spec expands the memory map format.

Linux is likely to get the memory map in the same format as it's
provided on native.
