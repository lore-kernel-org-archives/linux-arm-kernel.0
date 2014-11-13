From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Nov 2014 09:48:26 +0000
Subject: [PATCH 5/6] iommu/arm-smmu: support buggy implementations with
 invalidate-on-map
In-Reply-To: <vnkwy4rg5jqu.fsf@mitchelh-linux.qualcomm.com>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-6-git-send-email-mitchelh@codeaurora.org>
 <20141112182642.GH26437@arm.com>
 <vnkwy4rg5jqu.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <20141113094826.GA13350@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 06:58:17PM +0000, Mitchel Humpherys wrote:
> On Wed, Nov 12 2014 at 10:26:43 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Aug 13, 2014 at 01:51:38AM +0100, Mitchel Humpherys wrote:
> >> Add a workaround for some buggy hardware that requires a TLB invalidate
> >> operation to occur at map time. Activate the feature with the
> >> qcom,smmu-invalidate-on-map boolean DT property.
> >
> > I'm digging up an old thread here, but I've been working on a new page-table
> > allocator for the SMMU and looked into implementing this workaround for you
> > in there. When I do the TLBI on map after installing the new PTE, can I just
> > invalidate the range mapped by that PTE, or does it need to be a full TLBI?
> 
> I'm not totally sure on the history of the hardware errata but I believe
> it's just the range mapped by that pte.  We use SMMU_CBn_TLBIVA in the
> our smmu driver.
> 
> However, let's actually just drop this...  It's looking like the targets
> we have that will use the arm-smmu driver thankfully won't need this
> workaround.  Thanks for keeping this in mind though :)

Ha, damn, then I don't have a user of the shiny new quirks field I added!
I don't think I'll go as far as removing it altogether though...

Cheers,

Will
