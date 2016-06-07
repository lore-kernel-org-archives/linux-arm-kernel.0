From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jun 2016 11:58:23 +0100
Subject: next-20160607 build: 2 failures 9 warnings (next-20160607)
In-Reply-To: <E1bABXS-0001YX-Cz@optimist>
References: <E1bABXS-0001YX-Cz@optimist>
Message-ID: <20160607105823.GT7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 08:35:02AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ../drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h:19:27: fatal error: asm/dma-iommu.h: No such file or directory

introduced by 04f776734c4e (media: s5p-mfc: add iommu support) which
relies on a header which is only available on 32 bit ARM.  I suspect the
driver should be using linux/dma-iommu.h instead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/eae13f6d/attachment.sig>
