From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jun 2014 12:27:12 +0200
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <alpine.DEB.2.02.1406111035190.13771@kaball.uk.xensource.com>
References: <20140328184517.GA27219@cbox> <5397360B.80102@huawei.com>
 <alpine.DEB.2.02.1406111035190.13771@kaball.uk.xensource.com>
Message-ID: <13066173.0bm0kfOsEt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 June 2014 10:50:04 Stefano Stabellini wrote:
> Although not in the ARM VM System Specification, Xen is certainly going
> to support a fast boot path without UEFI firmware. I guess KVM will too.
> You'll have to rely on hypervisor specific mechanisms to achieve it.
> 
> In fact I wouldn't worry about UEFI when you need ACPI, that is not in
> this specification. Moreover the only hypervisor supporting virtio on
> ARM is KVM as far as I know.

Ah right, I missed the part about ACPI.

> > One aspect of this is that we currently start executing the image directly (no UEFI involved on the guest),
> > and in some cases we might not need a full fledged file system at all,
> > as the communication can happen via virtio channels.
> > 
> > We do have a need for ACPI for discovery of information like gic addresses, 
> > timers, interrupts... (no interest on device trees, really), and of PCI-E.

I wonder how you'd expect to find the ACPI data when there is no UEFI.
It's not likely that any hypervisor would ship with an ACPI implementation
that is independent of UEFI, because Linux (or any other full OS for
that matter) would support that scenario. You could of course link OSv
with an ACPI binary that is specific to KVM, but then I don't know why
you wouldn't just hardcode the data in OSv directly.

	Arnd
