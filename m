From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 26 Feb 2014 21:19:05 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <5553754.0b4gMg5OS7@wuerfel>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
Message-ID: <530E4C39.9010804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 26/02/2014 20:55, Arnd Bergmann ha scritto:
>> > For more information about UEFI and ACPI booting, see [4] and [5].
> What's the point of having ACPI in a virtual machine? You wouldn't
> need to abstract any of the hardware in AML since you already know
> what the virtual hardware is, so I can't see how this would help
> anyone.

In x86 land it's been certainly helpful to abstract hotplug 
capabilities.  For ARM it could be the same.  Not so much for PCI (ARM 
probably can use native PCIe hotplug and standard hotplug controllers; 
on x86 we started with PCI and also have to deal with Windows's lack of 
support for SHPC), but it could help for CPU and memory hotplug.

> Did you notice we are removing mach-virt now? Probably no point
> mentioning it here.

Peter, do we still want mach-virt support in QEMU then?

Paolo
