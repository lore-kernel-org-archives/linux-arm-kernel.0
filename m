From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Jun 2015 18:06:22 +0100
Subject: next-20150629 build: 1 failures 74 warnings (next-20150629)
In-Reply-To: <E1Z9WQC-000356-Bd@optimist>
References: <E1Z9WQC-000356-Bd@optimist>
Message-ID: <20150629170622.GJ11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 11:36:17AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> ../drivers/gpu/drm/exynos/exynos_drm_g2d.c:465:7: error: 'vec' undeclared (first use in this function)

caused by "drm/exynos: convert g2d_userptr_get_dma_addr() to use
get_vaddr_frames()" which has an obvious bug testing the return value of
frame_vector_create() by trying to look at vec rather than g2d_userptr->vec.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150629/bb8a60ef/attachment-0001.sig>
