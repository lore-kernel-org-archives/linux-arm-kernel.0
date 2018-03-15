From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 15 Mar 2018 11:52:00 +0100
Subject: [PATCH v2] media: omap3isp: fix unbalanced dma_iommu_mapping
In-Reply-To: <20180314154136.16468-1-s-anna@ti.com>
References: <20180314154136.16468-1-s-anna@ti.com>
Message-ID: <20180315105200.GA27057@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-03-14 10:41:36, Suman Anna wrote:
> The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
> ARM DMA backend. The current code creates a dma_iommu_mapping and
> attaches this to the ISP device, but never detaches the mapping in
> either the probe failure paths or the driver remove path resulting
> in an unbalanced mapping refcount and a memory leak. Fix this properly.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> v2 Changes:
>  - Dropped the error_attach label, and returned directly from the
>    first error path (comments from Sakari)
>  - Added Sakari's Acked-by
> v1: https://patchwork.kernel.org/patch/10276759/
> 
> Pavel,
> I dropped your Tested-by from v2 since I modified the patch, can you
> recheck the new patch again? Thanks.

I updated to new -next version and re-ran the test.

Tested-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180315/f6f5b43e/attachment.sig>
