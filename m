From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Tue, 20 Jan 2015 11:45:55 -0800
Subject: [PATCH v7 2/2] iommu/arm-smmu: add support for iova_to_phys
 through ATS1PR
In-Reply-To: <20150120141643.GA1549@arm.com> (Will Deacon's message of "Tue,
 20 Jan 2015 14:16:43 +0000")
References: <1414617220-21493-1-git-send-email-mitchelh@codeaurora.org>
 <1414617220-21493-3-git-send-email-mitchelh@codeaurora.org>
 <20150120141643.GA1549@arm.com>
Message-ID: <vnkwmw5d44ng.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20 2015 at 06:16:43 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hey Mitch,
>
> On Wed, Oct 29, 2014 at 09:13:40PM +0000, Mitchel Humpherys wrote:
>> Currently, we provide the iommu_ops.iova_to_phys service by doing a
>> table walk in software to translate IO virtual addresses to physical
>> addresses. On SMMUs that support it, it can be useful to ask the SMMU
>> itself to do the translation. This can be used to warm the TLBs for an
>> SMMU. It can also be useful for testing and hardware validation.
>> 
>> Since the address translation registers are optional on SMMUv2, only
>> enable hardware translations when using SMMUv1 or when SMMU_IDR0.S1TS=1
>> and SMMU_IDR0.ATOSNS=0, as described in the ARM SMMU v1-v2 spec.
>> 
>> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
>> ---
>> Changes since v6:
>>   - added missing lock
>>   - fixed physical address mask
>
> I had a go at rebasing this onto my current queue, but ended up making
> quite a few changes. Can you take a look at the result, please?
>
> Patch below (also on my for-joerg/arm-smmu/updates branch).

The modified patch looks good to me.  Thanks!

-Mitch


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
