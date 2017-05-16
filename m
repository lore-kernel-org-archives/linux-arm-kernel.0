From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 16 May 2017 11:01:54 +0100
Subject: [PATCH v3 0/2] kvm: arm/arm64: Fixes for race conditions
In-Reply-To: <20170516095318.GA5259@cbox>
References: <1494927295-29369-1-git-send-email-suzuki.poulose@arm.com>
 <20170516095318.GA5259@cbox>
Message-ID: <2b4cd91d-6d0f-3614-faa8-1ebe58bf1313@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/17 10:53, Christoffer Dall wrote:
> On Tue, May 16, 2017 at 10:34:53AM +0100, Suzuki K Poulose wrote:
>> The patches fixes race conditions in stage2 pgd accesses.
>>
>> Patch 1 is a fix up for the patch which has already been pushed to
>> kvmarm/master.
>>
>> Patch 2 fixes a case where stage2 PGD could be free'd when we release
>> the kvm->mmu_lock to prevent VCPU starvation.
>>
>> Applies on kvmarm/master tree
>
> Thanks for the rebase and fix.
>
> Applied to master, and for both patches::
>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>
>

Thanks, I think these fixes needs to go to stable as well. I will wait for
these to hit mainline and then send a back port.

Suzuki
