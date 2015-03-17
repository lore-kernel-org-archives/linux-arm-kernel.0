From: stripathi@apm.com (Suman Tripathi)
Date: Wed, 18 Mar 2015 05:03:19 +0530
Subject: [PATCH] Add support for CONFIG_ARM64_DMA_USE_IOMMU.
In-Reply-To: <CAOHikRCSoijzZ8oKEtMadEHOvLiWLO6fWkqiGEiPyb+Egb_1rw@mail.gmail.com>
References: <1422379495-10268-1-git-send-email-stripathi@apm.com>
 <20150128112718.GE6646@e104818-lin.cambridge.arm.com>
 <CAOHikRCSoijzZ8oKEtMadEHOvLiWLO6fWkqiGEiPyb+Egb_1rw@mail.gmail.com>
Message-ID: <CAOHikRCSYy6Zd=Oi34-KnyhG=bY8-XdD_QpdndbC_dCox8sJEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I guess there is an overlap with this thread:

http://thread.gmane.org/gmane.linux.kernel.iommu/8213

I would rather go for a more generic solution that Robin (cc'ed) is
trying to implement.

I followed the above thread but our requirement deviates from normal
IOMMU conventions.
For our case we need a 1:1 mapping of PA to IOVA. Actually our's is
not a real IOMMU (ie not having a cap of page table walk). It's a
simple 32-bit from (device side ) ot 64-bit (cpu side) address
translation with the help of a set of window registers. So we want to
bypass the entire iova .

Any suggestions on this ?

On Wed, Mar 18, 2015 at 5:02 AM, Suman Tripathi <stripathi@apm.com> wrote:
> I guess there is an overlap with this thread:
>
> http://thread.gmane.org/gmane.linux.kernel.iommu/8213
>
> I would rather go for a more generic solution that Robin (cc'ed) is
> trying to implement.
>
> I followed the above thread but our requirement deviates from normal IOMMU
> conventions.
> For our case we need a 1:1 mapping of PA to IOVA. Actually our's is not a
> real IOMMU (ie not having a cap of page table walk). It's a simple 32-bit
> from (device side ) ot 64-bit (cpu side) address translation with the help
> of a set of window registers. So we want to bypass the entire iova .
>
> Any suggestions on this ?
>
> On Wed, Jan 28, 2015 at 4:57 PM, Catalin Marinas <catalin.marinas@arm.com>
> wrote:
>>
>> On Tue, Jan 27, 2015 at 05:24:54PM +0000, Suman Tripathi wrote:
>> > This patch implements the support for ARM64_DMA_USE_IOMMU
>> > ported from ARM 32-bit.
>> >
>> > Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> > ---
>> >
>> > Suman Tripathi (1):
>> >   arm64: dma-mapping: Support for ARM64_DMA_USE_IOMMU.
>> >
>> >  arch/arm64/Kconfig                 |  24 ++
>> >  arch/arm64/include/asm/device.h    |   9 +
>> >  arch/arm64/include/asm/dma-iommu.h |  48 +++
>> >  arch/arm64/mm/dma-mapping.c        | 611
>> > +++++++++++++++++++++++++++++++++++++
>> >  4 files changed, 692 insertions(+)
>> >  create mode 100644 arch/arm64/include/asm/dma-iommu.h
>>
>> I guess there is an overlap with this thread:
>>
>> http://thread.gmane.org/gmane.linux.kernel.iommu/8213
>>
>> I would rather go for a more generic solution that Robin (cc'ed) is
>> trying to implement.
>>
>> --
>> Catalin
>
>
>
>
> --
> Thanks,
> with regards,
> Suman Tripathi



-- 
Thanks,
with regards,
Suman Tripathi
