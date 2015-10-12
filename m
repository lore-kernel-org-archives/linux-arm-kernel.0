From: jroedel@suse.de (Joerg Roedel)
Date: Mon, 12 Oct 2015 23:58:30 +0200
Subject: [PATCH 13/20] intel-iommu: switch from ioremap_cache to memremap
In-Reply-To: <20151009221646.32203.98367.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221646.32203.98367.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <20151012215830.GT10641@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On Fri, Oct 09, 2015 at 06:16:46PM -0400, Dan Williams wrote:
> In preparation for deprecating ioremap_cache() convert its usage in
> intel-iommu to memremap.  This also eliminates the mishandling of the
> __iomem annotation in the implementation.

I appreciate the change, but in the cover letter you write the API is
only implemented for x86 so far? The VT-d driver is also used on ia64,
will it still work there with this patch?


	Joerg
