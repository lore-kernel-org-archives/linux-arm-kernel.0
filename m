From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 1 Aug 2013 19:42:52 +0100
Subject: [ARM ATTEND] Describing complex, non-probable system topologies
In-Reply-To: <20130801183531.GB29831@mudshark.cambridge.arm.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
Message-ID: <20130801184252.GB19325@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 07:35:31PM +0100, Will Deacon wrote:
> Hello,
> 
> Whilst Linux implements a bunch of different bus types (many of which
> are in fact virtual), devices sitting on non-probable, memory mapped
> buses inside SoCs typically live on either the platform_bus or the
> amba_bus. So far, this has worked out alright; the buses haven't needed
> to be visible to software and no additional software control is really
> required from the OS. However, as I/O coherency and hardware
> virtualisation capabilities start to creep into ARM-based SoCs, Linux
> needs to know the topology of the system on which it is running.
> 
> Naturally, this would need to be described as a device-tree binding and
> communicate:
> 
>   - Buses which can be configured as coherent, including which devices
>     on those buses can be made coherent.
> 
>   - How IOMMUs sit on the bus and interact with masters on that bus (the
>     current one-IOMMU-driver-per-bus may not work well for the
>     platform_bus).
> 
>   - QoS and PM constraints. This isn't really in my area, but we do have
>     buses that have these features and expect software to control them.
> 
>   - The system topology and linkages between buses and devices.
> 
> The last point is increasingly important as various blocks of ARM system
> IP start to require knowledge of masters and how things like memory
> traffic, DVM messages, interrupts (think MSI) etc are routed between
> them in order to configure the system correctly. For example, interfacing
> a PCIe device with an SMMU requires knowledge of both the requester id
> associated with the device and how that maps to incoming stream ids
> (based off the AXI bus id) on the SMMU. Even worse, this mapping is
> likely generated dynamically by the host controller, which would need to
> know about downstream buses and their SMMUs.
> 
> Other than that, I'd be interested in attending since I'm fairly active
> on the architectural side of things and keen to follow any discussions
> that may impact core architectural code. Previous ARM mini-summits have been
> a great success, so I'm really looking forward to this one.

+1

This area of discussion has come up a couple of times before as a biggie
looming on the horizon which we'll have to sort out before every SoC
vendor rolls their own solution ... but it's not sorted yet.

Cheers
---Dave
