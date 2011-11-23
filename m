From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Nov 2011 23:39:57 +0000
Subject: [PATCH] arm: dma:  Drop GFP_COMP for DMA memory allocations
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C785@HQMAIL01.nvidia.com>
References: <1320442539-7753-1-git-send-email-swarren@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174080512F@HQMAIL01.nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174F08C785@HQMAIL01.nvidia.com>
Message-ID: <20111123233957.GM9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 11:10:03AM -0800, Stephen Warren wrote:
> Stephen Warren wrote at Wednesday, November 09, 2011 11:04 AM:
> > Stephen Warren wrote at Friday, November 04, 2011 3:36 PM:
> > > dma_alloc_coherent wants to split pages after allocation in order to
> > > reduce the memory footprint. This does not work well with GFP_COMP
> > > pages, so drop this flag before allocation.
> > >
> > > This patch is ported from arch/avr32
> > > (commit 3611553ef985ef7c5863c8a94641738addd04cff).
> > >
> > > Signed-off-by: Sumit Bhattacharya <sumitb@nvidia.com>
> > > Tested-by: Varun Colbert <vcolbert@nvidia.com>
> > > [swarren: s/HUGETLB_PAGE/HUGETLBFS/ in comment, minor comment cleanup]
> > > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > 
> > Russell, does this look good to go in the patch system now?
> 
> ping?

I think so.
