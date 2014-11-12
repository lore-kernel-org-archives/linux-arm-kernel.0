From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 12 Nov 2014 10:58:17 -0800
Subject: [PATCH 5/6] iommu/arm-smmu: support buggy implementations with
 invalidate-on-map
In-Reply-To: <20141112182642.GH26437@arm.com> (Will Deacon's message of "Wed,
 12 Nov 2014 18:26:43 +0000")
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-6-git-send-email-mitchelh@codeaurora.org>
 <20141112182642.GH26437@arm.com>
Message-ID: <vnkwy4rg5jqu.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12 2014 at 10:26:43 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Mitch,
>
> On Wed, Aug 13, 2014 at 01:51:38AM +0100, Mitchel Humpherys wrote:
>> Add a workaround for some buggy hardware that requires a TLB invalidate
>> operation to occur at map time. Activate the feature with the
>> qcom,smmu-invalidate-on-map boolean DT property.
>
> I'm digging up an old thread here, but I've been working on a new page-table
> allocator for the SMMU and looked into implementing this workaround for you
> in there. When I do the TLBI on map after installing the new PTE, can I just
> invalidate the range mapped by that PTE, or does it need to be a full TLBI?

I'm not totally sure on the history of the hardware errata but I believe
it's just the range mapped by that pte.  We use SMMU_CBn_TLBIVA in the
our smmu driver.

However, let's actually just drop this...  It's looking like the targets
we have that will use the arm-smmu driver thankfully won't need this
workaround.  Thanks for keeping this in mind though :)


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
