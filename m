From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Nov 2014 18:26:43 +0000
Subject: [PATCH 5/6] iommu/arm-smmu: support buggy implementations with
 invalidate-on-map
In-Reply-To: <1407891099-24641-6-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-6-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20141112182642.GH26437@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mitch,

On Wed, Aug 13, 2014 at 01:51:38AM +0100, Mitchel Humpherys wrote:
> Add a workaround for some buggy hardware that requires a TLB invalidate
> operation to occur at map time. Activate the feature with the
> qcom,smmu-invalidate-on-map boolean DT property.

I'm digging up an old thread here, but I've been working on a new page-table
allocator for the SMMU and looked into implementing this workaround for you
in there. When I do the TLBI on map after installing the new PTE, can I just
invalidate the range mapped by that PTE, or does it need to be a full TLBI?

Will
