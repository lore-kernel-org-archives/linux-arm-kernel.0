From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Nov 2017 08:56:32 +0000
Subject: [PATCH v5 17/26] KVM: arm/arm64: GICv4: Handle INVALL applied to
 a vPE
In-Reply-To: <20171110084115.GJ14144@cbox>
References: <20171027142855.21584-1-marc.zyngier@arm.com>
 <20171027142855.21584-18-marc.zyngier@arm.com>
 <e247390a-c9d5-4c3a-5812-88b83e87ce10@redhat.com>
 <20171110084115.GJ14144@cbox>
Message-ID: <2c791b55-f16d-5e2b-a876-126239cf04d1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/17 08:41, Christoffer Dall wrote:
> On Tue, Nov 07, 2017 at 10:23:25PM +0100, Auger Eric wrote:
>> Hi Marc,
>>
>> On 27/10/2017 16:28, Marc Zyngier wrote:
>>> Since when updating the properties one LPI at a time, there is no
>> Since we update the properties one LPI at a time, ... ?
>>> need to perform an INV each time we read one. Instead, we rely
>>> on the final VINVALL that gets sent to the ITS to do the work.
>> The commit message is not crystal clear for me.
>>
>> I understand in case of vgic_its_cmd_handle_invall you want to avoid
>> doing an invalidation for each physical irq but rather do an
>> its_invall_vpe at the end. So you add a new  @needs_inv arg to
>> update_lpi_config to tell whether the invalidation should be done or not.
> 
> I've reworded it to:
> 
>   There is no need to perform an INV for each interrupt when updating
>   multiple interrupts.  Instead, we can rely on the final VINVALL that
>   gets sent to the ITS to do the work for all of them.
> 
> 
> Shout quickly if you have any objections.

Works for me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
