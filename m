From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Oct 2013 14:17:19 +0100
Subject: [PATCH 7/7] kvmtool: virtio: enable arm/arm64 support for
 bi-endianness
In-Reply-To: <525BEC2C.6050905@redhat.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
 <1381502195-8263-8-git-send-email-marc.zyngier@arm.com>
 <525BEC2C.6050905@redhat.com>
Message-ID: <525BEEDF.1090906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/13 14:05, Paolo Bonzini wrote:
> Il 11/10/2013 16:36, Marc Zyngier ha scritto:
>> Cc: Pekka Enberg <penberg@kernel.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  tools/kvm/arm/include/arm-common/kvm-arch.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/kvm/arm/include/arm-common/kvm-arch.h b/tools/kvm/arm/include/arm-common/kvm-arch.h
>> index 72b204f..91836cb 100644
>> --- a/tools/kvm/arm/include/arm-common/kvm-arch.h
>> +++ b/tools/kvm/arm/include/arm-common/kvm-arch.h
>> @@ -27,6 +27,8 @@
>>  
>>  #define VIRTIO_DEFAULT_TRANS	VIRTIO_MMIO
>>  
>> +#define VIRTIO_RING_ENDIAN	((1UL << VIRTIO_RING_F_GUEST_LE) | (1UL << VIRTIO_RING_F_GUEST_BE))
>> +
>>  static inline bool arm_addr_in_ioport_region(u64 phys_addr)
>>  {
>>  	u64 limit = KVM_IOPORT_AREA + ARM_IOPORT_SIZE;
>>
> 
> Why only arm/arm64?

Because it has a runtime impact (testing the queue endianness on each
access is not free). Also, I have no idea how much of an interest other
arches have when it comes to mixed endianness.

	M.
-- 
Jazz is not dead. It just smells funny...
