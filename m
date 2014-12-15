From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Dec 2014 09:45:06 +0000
Subject: [PATCH 1/4] iommu: introduce generic page table allocation
 framework
In-Reply-To: <1610022.OYQk9afzNc@avalon>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <1417089078-22900-2-git-send-email-will.deacon@arm.com>
 <1610022.OYQk9afzNc@avalon>
Message-ID: <20141215094506.GB20738@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 11:46:30PM +0000, Laurent Pinchart wrote:
> > +struct io_pgtable_cfg {
> > +	int			quirks; /* IO_PGTABLE_QUIRK_* */
> > +	unsigned long		pgsize_bitmap;
> > +	unsigned int		ias;
> > +	unsigned int		oas;
> > +	struct iommu_gather_ops	*tlb;
> 
> Could you make this pointer const ?

Sure. I'll post a v2 at -rc1 assuming I'm not fishing/drinking (I'm off
work from Wednesday this week).

Will
