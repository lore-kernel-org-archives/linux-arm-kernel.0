From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Tue, 06 Jan 2015 12:16:25 -0800
Subject: [PATCH] iommu/arm-smmu: don't touch the secure STLBIALL register
In-Reply-To: <20150106141507.GB3484@arm.com> (Will Deacon's message of "Tue, 6
 Jan 2015 14:15:07 +0000")
References: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
 <20150106141507.GB3484@arm.com>
Message-ID: <vnkwiogjhdgm.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06 2015 at 06:15:07 AM, Will Deacon <will.deacon@arm.com> wrote:
>>  	/* Invalidate the TLB, just in case */
>> -	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
>>  	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>>  	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>
> I was slightly worried that this would break the Calxeda implementation
> with ARM_SMMU_OPT_SECURE_CFG_ACCESS, but actually these registers aren't
> even aliased there so I think there's a bigger bug for them.
>
> Anyway, given that their hardware has gone the way of the dodo, I'll take
> the patch as-is unless you have any further comments?
>
> Will

Yeah I agree that this shouldn't affect the (now defunct) Calxeda
implementation.  I've tested this on some hardware here and we crash
when we touch that register since it's secure-only (not banked, as you
mentioned).


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
