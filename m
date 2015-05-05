From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 May 2015 18:05:41 +0100
Subject: [RFC PATCH] iommu: add ARM short descriptor page table allocator.
In-Reply-To: <20150505161802.GA20611@8bytes.org>
References: <1430206881-18294-1-git-send-email-yong.wu@mediatek.com>
 <20150505161802.GA20611@8bytes.org>
Message-ID: <20150505170541.GN1550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 05:18:02PM +0100, Joerg Roedel wrote:
> On Tue, Apr 28, 2015 at 03:41:21PM +0800, Yong Wu wrote:
> > This patch is for ARM Short Descriptor Format.It has 2-levels
> > pagetable and the allocator supports 4K/64K/1M/16M.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/Kconfig                |   7 +
> >  drivers/iommu/Makefile               |   1 +
> >  drivers/iommu/io-pgtable-arm-short.c | 489 +++++++++++++++++++++++++++++++++++
> >  drivers/iommu/io-pgtable.c           |   4 +
> >  drivers/iommu/io-pgtable.h           |   6 +
> >  5 files changed, 507 insertions(+)
> >  create mode 100644 drivers/iommu/io-pgtable-arm-short.c
> 
> What is the context of this, where will it be used?

I think the MT8173 IOMMU [1] uses this format and, since it's part of
the ARM architecture, the ARM SMMU can make use of it too if the
implementation supports it.

Will

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html
