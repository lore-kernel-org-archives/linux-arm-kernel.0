From: joro@8bytes.org (joro at 8bytes.org)
Date: Mon, 18 Aug 2014 23:26:27 +0200
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <53F266AE.40303@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
 <871tsm5vcn.fsf@nvidia.com>
 <CAF6AEGvZUanVtPxAt76+AAdOaNwyMJ3cmcJ1srsEYBeG7ELkBQ@mail.gmail.com>
 <53EA472B.3020900@codeaurora.org>
 <20140818140730.GC9809@8bytes.org>
 <CAF6AEGtGmAQjMc5W5a6x5QiyUc8v0XHcsNAFe65Znc=DDKPS+w@mail.gmail.com>
 <53F266AE.40303@codeaurora.org>
Message-ID: <20140818212627.GI9809@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 01:48:46PM -0700, Olav Haugan wrote:
> On 8/18/2014 11:32 AM, Rob Clark wrote:

> No, I do not have other uses right now. But could imagine use cases like
> "force <insert minimum mapping size here> mapping" flag etc.

I think it is worth discussing to add a flush() function to the
IOMMU-API. I sent a patch-set myself a few years ago introducing an
iommu_commit() function with the same semantics, but this is
out-of-scope for this patch-set.

Also adding a flag parameter to iommu_map_sg would introduce an
asymentrie in the API to the iommu_map() function. So please leave it
out for this patch-set, when we really need a flag parameter someday we
can introduce it for iommu_map() and iommu_map_sg() together.


	Joerg
