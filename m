From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Aug 2014 10:48:23 +0100
Subject: [PATCH v1 2/2] iommu/arm-smmu: Correctly program S2CR and SMR
 registers
In-Reply-To: <1407113264-23426-3-git-send-email-ohaugan@codeaurora.org>
References: <1407113264-23426-1-git-send-email-ohaugan@codeaurora.org>
 <1407113264-23426-3-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140804094823.GD15117@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 01:47:44AM +0100, Olav Haugan wrote:
> When stream matching is supported by the hardware the S2CR is indexed
> by the stream matching register group index and not the stream id.
> Fix the programming of the S2CR register to ensure it is programmed
> correctly in both cases.
> 
> In addition, the SMR registers does not exist when stream matching is not
> supported by the hardware. Avoid writing to this register if not needed.

I've already fixed some/all of this in my iommu/pci branch:

  https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=iommu/pci&id=d4e46030b91367b50ecb544fee021b30e4ec4e9a

Can you try rebasing on that and see if there's anything left to do, please?

Once we get to -rc1, I'll sort out my branches so the iommu/devel branch
will contain stuff that I consider candidates for merging (since the
iommu/pci branch contains a bunch of WIP/RFC stuff too)

Cheers,

Will
