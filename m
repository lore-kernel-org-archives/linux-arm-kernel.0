From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Nov 2018 00:02:13 -0800
Subject: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
In-Reply-To: <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122082336.GA2049@infradead.org>
 <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
Message-ID: <20181126080213.GA17809@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 01:23:41PM +0100, Vlastimil Babka wrote:
> Is this also true for caches created by kmem_cache_create(), that
> debugging options can result in not respecting the alignment passed to
> kmem_cache_create()? That would be rather bad, IMHO.

That's what I understood in the discussion.  If not it would make
our live simpler, but would need to be well document.

Christoph can probably explain the alignment choices in slub.

> 
> > But I do agree with the sentiment of not wanting to spread GFP_DMA32
> > futher into the slab allocator.
> 
> I don't see a problem with GFP_DMA32 for custom caches. Generic
> kmalloc() would be worse, since it would have to create a new array of
> kmalloc caches. But that's already ruled out due to the alignment.

True, purely slab probably isn't too bad.
