From: jack@suse.cz (Jan Kara)
Date: Tue, 30 Jun 2015 08:11:33 +0200
Subject: next-20150629 build: 1 failures 74 warnings (next-20150629)
In-Reply-To: <20150629170622.GJ11162@sirena.org.uk>
References: <E1Z9WQC-000356-Bd@optimist> <20150629170622.GJ11162@sirena.org.uk>
Message-ID: <20150630061133.GA7252@quack.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 29-06-15 18:06:22, Mark Brown wrote:
> On Mon, Jun 29, 2015 at 11:36:17AM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an ARM allmodconfig due to:
> 
> > ../drivers/gpu/drm/exynos/exynos_drm_g2d.c:465:7: error: 'vec' undeclared (first use in this function)
> 
> caused by "drm/exynos: convert g2d_userptr_get_dma_addr() to use
> get_vaddr_frames()" which has an obvious bug testing the return value of
> frame_vector_create() by trying to look at vec rather than g2d_userptr->vec.

Thanks for notice. Attached is a fixed version of the patch.

								Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-drm-exynos-Convert-g2d_userptr_get_dma_addr-to-use-g.patch
Type: text/x-patch
Size: 7689 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150630/4b3e469d/attachment.bin>
