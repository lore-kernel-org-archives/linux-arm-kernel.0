From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 30 Aug 2017 15:56:57 +0100
Subject: [PATCH v3 49/59] KVM: arm/arm64: GICv4: Propagate VLPI properties
 at map time
In-Reply-To: <20170828181841.GJ24649@cbox>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
 <20170731172637.29355-50-marc.zyngier@arm.com> <20170828181841.GJ24649@cbox>
Message-ID: <60012f9d-7eb9-e8f4-a2c4-82e00ff52c0c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/17 19:18, Christoffer Dall wrote:
> On Mon, Jul 31, 2017 at 06:26:27PM +0100, Marc Zyngier wrote:
>> When the VLPI gets mapped, it must inherit the configuration of
>> LPI configured at the vITS level. FOr that purpose, let's make
> 
> *the LPI
> *For that

Will fix, thanks.

> 
>> update_lpi_config globally available and call it just after
>> having performed the VLPI map operation.
>>
> 
> I assume this means that the GIC compares the priorities of virtual
> interrupts in the LRs with the priorities of the pending VLPIs and
> figures out what to signal first?  I couldn't find anywhere in the spec
> where this is explicitly stated.

There is this mention in IHI0069D, 5.4 (Virtual LPI support):

"The Redistributor associated with the PE on which the vPE is scheduled
determines the highest priority pending vLPI, and forwards this to the
virtual CPU interface of the vPE. This vLPI and the interrupts in the
List register are then prioritized together to determine the highest
priority pending virtual interrupt for the vPE."

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
