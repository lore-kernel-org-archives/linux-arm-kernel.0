From: mhocko@kernel.org (Michal Hocko)
Date: Fri, 27 Jan 2017 17:19:04 +0100
Subject: [PATCH 1/3] mm: alloc_contig_range: allow to specify GFP mask
In-Reply-To: <81849c0d-b7aa-faf2-484c-66b0ea0a7e95@suse.cz>
References: <20170119170707.31741-1-l.stach@pengutronix.de>
 <81849c0d-b7aa-faf2-484c-66b0ea0a7e95@suse.cz>
Message-ID: <20170127161904.GA6357@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 20-01-17 13:35:40, Vlastimil Babka wrote:
> On 01/19/2017 06:07 PM, Lucas Stach wrote:
[...]
> > @@ -7255,7 +7256,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
> >  		.zone = page_zone(pfn_to_page(start)),
> >  		.mode = MIGRATE_SYNC,
> >  		.ignore_skip_hint = true,
> > -		.gfp_mask = GFP_KERNEL,
> > +		.gfp_mask = gfp_mask,
> 
> I think you should apply memalloc_noio_flags() here (and Michal should
> then convert it to the new name in his scoped gfp_nofs series). Note
> that then it's technically a functional change, but it's needed.
> Otherwise looks good.

yes, with that added, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> 
> >  	};
> >  	INIT_LIST_HEAD(&cc.migratepages);
> >  
> > 

-- 
Michal Hocko
SUSE Labs
