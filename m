From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 31 Mar 2015 15:14:41 +0200
Subject: [PATCH 00/16 v2] iommu: Move domain allocation into drivers
In-Reply-To: <1427516662.3643.906.camel@redhat.com>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
 <1427516662.3643.906.camel@redhat.com>
Message-ID: <20150331131441.GD4441@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Fri, Mar 27, 2015 at 10:24:22PM -0600, Alex Williamson wrote:
> For 1-5,16
> 
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

Thanks a lot for your review.

> My only comment/question is whether you'd want to consider using
> ERR_PTR() return values from domain_alloc().  It's an alloc functions,
> so NULL == -ENOMEM is pretty standard, but we could at least have the
> interface to the iommu driver return more info even if we continue to
> mask that as NULL out to the IOMMU API users for now.  Thanks,

Yes, that might make sense. But to do anything useful with the ERR_PTR
we also need to change the iommu_domain_alloc() interface. This is
out-of-scope for this patch-set, we can discuss this seperatly.


	Joerg
