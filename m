From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 21 Mar 2017 18:38:21 +0100
Subject: [PATCH v3 03/19] arm/arm64: vgic: turn vgic_find_mmio_region into
 public
In-Reply-To: <7b4aa19d-d413-7714-a317-b9e59a2fbf88@arm.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
 <1488800074-21991-4-git-send-email-eric.auger@redhat.com>
 <7b4aa19d-d413-7714-a317-b9e59a2fbf88@arm.com>
Message-ID: <4c088b8f-42af-c907-8133-b45f3d9c3031@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 17/03/2017 15:38, Andre Przywara wrote:
> Hi Eric,
> 
> On 06/03/17 11:34, Eric Auger wrote:
>> We plan to use vgic_find_mmio_region in vgic-its.c so let's
>> turn it into a public function.
> 
> Just a nit below, but for the patch:
> 
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
First thank you for the whole series review.
> 
>> ---
>>  virt/kvm/arm/vgic/vgic-mmio.c | 3 +--
>>  virt/kvm/arm/vgic/vgic-mmio.h | 5 +++++
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
>> index 3654b4c..0427ddb 100644
>> --- a/virt/kvm/arm/vgic/vgic-mmio.c
>> +++ b/virt/kvm/arm/vgic/vgic-mmio.c
>> @@ -430,8 +430,7 @@ static int match_region(const void *key, const void *elt)
>>  	return 0;
>>  }
>>  
>> -/* Find the proper register handler entry given a certain address offset. */
>> -static const struct vgic_register_region *
>> +const struct vgic_register_region *
>>  vgic_find_mmio_region(const struct vgic_register_region *region, int nr_regions,
>>  		      unsigned int offset)
>>  {
>> diff --git a/virt/kvm/arm/vgic/vgic-mmio.h b/virt/kvm/arm/vgic/vgic-mmio.h
>> index 98bb566..055ad42 100644
>> --- a/virt/kvm/arm/vgic/vgic-mmio.h
>> +++ b/virt/kvm/arm/vgic/vgic-mmio.h
>> @@ -192,4 +192,9 @@ u64 vgic_sanitise_shareability(u64 reg);
>>  u64 vgic_sanitise_field(u64 reg, u64 field_mask, int field_shift,
>>  			u64 (*sanitise_fn)(u64));
>>  
>> +/* Find the proper register handler entry given a certain address offset */
>> +const struct vgic_register_region *
>> +vgic_find_mmio_region(const struct vgic_register_region *region,
> 
> I wonder if we should use the opportunity to use the plural in the
> variable name here ("regions") to make it clear that this is an array
> (just needed some time myself here to remember what it does).
done, I renamed the region parameter into regions

Thanks

Eric
> 
> Cheers,
> Andre.
> 
>> +		      int nr_regions, unsigned int offset);
>> +
>>  #endif
>>
