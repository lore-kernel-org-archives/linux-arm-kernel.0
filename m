From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 27 May 2014 09:17:39 +0100
Subject: [PATCH v4 02/20] arm64: initial support for GICv3
In-Reply-To: <20140523164043.GA21298@e106794-lin.cambridge.arm.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <1400176719-31275-3-git-send-email-marc.zyngier@arm.com>
 <20140523164043.GA21298@e106794-lin.cambridge.arm.com>
Message-ID: <53844A23.6050801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/14 17:40, Jean-Philippe Brucker wrote:
> Hi Marc,
> 
> On Thu, May 15, 2014 at 06:58:21PM +0100, Marc Zyngier wrote:
>> The Generic Interrupt Controller (version 3) offers services that are
>> similar to GICv2, with a number of additional features:
>> - Affinity routing based on the CPU MPIDR (ARE)
>> - System register for the CPU interfaces (SRE)
>> - Support for more that 8 CPUs
>> - Locality-specific Peripheral Interrupts (LPIs)
>> - Interrupt Translation Services (ITS)
>>
>> This patch adds preliminary support for GICv3 with ARE and SRE,
>> non-secure mode only. It relies on higher exception levels to grant ARE
>> and SRE access.
>>
>> Support for LPI and ITS will be added at a later time.
>>
> [...]
>> +/*
>> + * Hypervisor interface registers (SRE only)
>> + */
>> +#define GICH_LR_VIRTUAL_ID_MASK                ((1UL << 32) - 1)
>> +
>> +#define GICH_LR_EOI                    (1UL << 41)
>> +#define GICH_LR_GROUP                  (1UL << 60)
>> +#define GICH_LR_STATE                  (3UL << 62)
>> +#define GICH_LR_PENDING_BIT            (1UL << 62)
>> +#define GICH_LR_ACTIVE_BIT             (1UL << 63)
>> +
> Minor nit:
> I think these names can be misleading, since the GICH_LR in GICv3 is the
> same as in GICv2, and is 32bit.
> Since AArch32 splits the LR into two system registers, it may be clearer
> to name these bits ICH_LR* on arm64, and ICH_LRC* on arm.

Good point, worth the change.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
