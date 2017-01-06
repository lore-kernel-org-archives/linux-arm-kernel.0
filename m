From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 6 Jan 2017 17:35:25 +0530
Subject: [PATCH V8 1/9] iommu: add IOMMU_PRIV attribute
In-Reply-To: <20170106110627.GO17255@8bytes.org>
References: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
 <1483362764-11990-2-git-send-email-sricharan@codeaurora.org>
 <20170106110627.GO17255@8bytes.org>
Message-ID: <00bc01d26815$2f357480$8da05d80$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Joerg Roedel
>Sent: Friday, January 06, 2017 4:36 PM
>To: Sricharan R <sricharan@codeaurora.org>
>Cc: mitchelh at codeaurora.org; pdaly at codeaurora.org; vinod.koul at intel.com; jgebben at codeaurora.org; will.deacon at arm.com;
>linux-kernel at vger.kernel.org; iommu at lists.linux-foundation.org; linux at armlinux.org.uk; jcrouse at codeaurora.org;
>dan.j.williams at intel.com; pratikp at codeaurora.org; tzeng at codeaurora.org; linux-arm-kernel at lists.infradead.org;
>robin.murphy at arm.com
>Subject: Re: [PATCH V8 1/9] iommu: add IOMMU_PRIV attribute
>
>On Mon, Jan 02, 2017 at 06:42:36PM +0530, Sricharan R wrote:
>> From: Mitchel Humpherys <mitchelh@codeaurora.org>
>>
>> Add the IOMMU_PRIV attribute, which is used to indicate privileged
>> mappings.
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Tested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> ---
>>  include/linux/iommu.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 0ff5111..8c15ada 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -31,6 +31,7 @@
>>  #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
>>  #define IOMMU_NOEXEC	(1 << 3)
>>  #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
>> +#define IOMMU_PRIV	(1 << 5) /* privileged */
>
>Since this is a new generic global flag, can you please add a more
>verbose comment telling what a 'privileged' mapping is about in the
>iommu-case? We should have a clear defined semantic for this flag or we
>might end up with different meanings for it with different
>iommu-hardware.

This flag is to inform the iommu api to setup privileged mappings
for the caller which can be accessed only by the master running with
supervisor/privileged permissions and inaccessible to less privileged
execution levels.

i will repost this with comment added.

Regards,
 Sricharan
