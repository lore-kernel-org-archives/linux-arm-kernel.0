From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Jan 2016 15:14:28 +0000
Subject: [PATCH V12 3/7] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <20160115145629.GI3262@leverpostej>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-4-git-send-email-okaya@codeaurora.org>
 <20160115145629.GI3262@leverpostej>
Message-ID: <56990CD4.6020405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/16 14:56, Mark Rutland wrote:
> Hi,
> 
> [adding KVM people, given this is meant for virtualization]
> 
> On Mon, Jan 11, 2016 at 09:45:43AM -0500, Sinan Kaya wrote:
>> The Qualcomm Technologies HIDMA device has been designed to support
>> virtualization technology. The driver has been divided into two to follow
>> the hardware design.
>>
>> 1. HIDMA Management driver
>> 2. HIDMA Channel driver
>>
>> Each HIDMA HW consists of multiple channels. These channels share some set
>> of common parameters. These parameters are initialized by the management
>> driver during power up. Same management driver is used for monitoring the
>> execution of the channels. Management driver can change the performance
>> behavior dynamically such as bandwidth allocation and prioritization.
>>
>> The management driver is executed in hypervisor context and is the main
>> management entity for all channels provided by the device.
> 
> You mention repeatedly that this is designed for virtualization, but
> looking at the series as it stands today I can't see how this operates
> from the host side.

Nor the guest's, TBH. How do host and guest communicate, what is the
infrastructure, how is it meant to be used? A lot of questions, and no
answer whatsoever in this series.

> 
> This doesn't seem to tie into KVM or VFIO, and as far as I can tell
> there's no mechanism for associating channels with a particular virtual
> address space (i.e. no configuration of an external or internal IOMMU),
> nor pinning of guest pages to allow for DMA to occur safely.
> 
> Given that, I'm at a loss as to how this would be used in a hypervisor
> context. What am I missing?
> 
> Are there additional patches, or do you have some userspace that works
> with this in some limited configuration?

Well, this looks so far like a code dumping exercise. I'd very much
appreciate a HIDMA101 crash course:

- How do host and guest communicate?
- How is the integration performed in the hypervisor?
- Does the HYP side requires any context switch (and how is that done)?
- What makes it safe?

Without any of this information (and pointer to the code to back it up),
I'm very reluctant to take any of this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
