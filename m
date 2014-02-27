From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 27 Feb 2014 12:27:58 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CACxGe6tjuytsYAn6Hadf0AK+REzHgRydgbHPafL8+Sdtd_tMUA@mail.gmail.com>
References: <20140226183454.GA14639@cbox>
 <CACxGe6tjuytsYAn6Hadf0AK+REzHgRydgbHPafL8+Sdtd_tMUA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1402271216040.31489@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Grant Likely wrote:
> > VM Platform
> > -----------
> > The specification does not mandate any specific memory map. ?The guest
> > OS must be able to enumerate all processing elements, devices, and
> > memory through HW description data (FDT, ACPI) or a bus-specific
> > mechanism such as PCI.
> >
> > The virtual platform must support at least one of the following ARM
> > execution states:
> > ? (1) aarch32 virtual CPUs on aarch32 physical CPUs
> > ? (2) aarch32 virtual CPUs on aarch64 physical CPUs
> > ? (3) aarch64 virtual CPUs on aarch64 physical CPUs
> >
> > It is recommended to support both (2) and (3) on aarch64 capable
> > physical systems.
> >
> > The virtual hardware platform must provide a number of mandatory
> > peripherals:
> >
> > ? Serial console: ?The platform should provide a console,
> > ? based on an emulated pl011, a virtio-console, or a Xen PV console.
> 
> For portable disk image, can Xen PV be dropped from the list? pl011 is part of SBSA, and virtio is getting standardised, but Xen PV is
> implementation specific.

Does an interface need OASIS' rubber stamp to be "standard"?  If so, we
should also drop FDT from this document. The SBSA has not been published
by any OASIS-like standardization body either, so maybe we should drop
the SBSA too.

If it doesn't need OASIS nice logo on the side to be a standard, then
the Xen PV interfaces are a standard too. Give a look at
xen/include/public/io, they go as back as 2004, and they have multiple
different implementations of the frontends and backends in multiple
operating systems today.

There is no reason why another hypervisor couldn't implement the same
interface and in fact I know for a fact that it was considered for KVM.
