From: mhocko@kernel.org (Michal Hocko)
Date: Fri, 23 Nov 2018 13:30:40 +0100
Subject: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
In-Reply-To: <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122082336.GA2049@infradead.org>
 <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
Message-ID: <20181123123040.GH8625@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23-11-18 13:23:41, Vlastimil Babka wrote:
> On 11/22/18 9:23 AM, Christoph Hellwig wrote:
[...]
> > But I do agree with the sentiment of not wanting to spread GFP_DMA32
> > futher into the slab allocator.
> 
> I don't see a problem with GFP_DMA32 for custom caches. Generic
> kmalloc() would be worse, since it would have to create a new array of
> kmalloc caches. But that's already ruled out due to the alignment.

Yes that makes quite a lot of sense to me. We do not really need a
generic support. Just make sure that if somebody creates a GFP_DMA32
restricted cache then allow allocating restricted memory from that.

Is there any fundamental reason that this wouldn't be possible?
-- 
Michal Hocko
SUSE Labs
