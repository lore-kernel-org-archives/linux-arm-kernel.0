From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 Apr 2018 09:15:34 -0700
Subject: [PATCH] net: thunderx: rework mac addresses list to u64 array
In-Reply-To: <20180405160749.GB12703@localhost.localdomain>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180405150748.GA5716@infradead.org>
 <20180405160749.GB12703@localhost.localdomain>
Message-ID: <20180405161534.GA18042@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 09:07:49AM -0700, Vadim Lomovtsev wrote:
> > 
> > > +				mc_list = kmalloc(sizeof(*mc_list) +
> > > +						  sizeof(u64) * netdev_mc_count(netdev),
> > > +						  GFP_ATOMIC);
> > 
> > kmalloc_array(), please.
> 
> In this case it would require two memory allocation calls to kmalloc() for
> xcast_addr_list struct and to kmalloc_array() for 'mc' addresses, becasue of
> different data types and so two null-ptr checks .. this is what I'd like get rid off.
> 
> My idea of this was to keep number of array elements and themselves within the
> same memory block/page to reduce number of memory allocation requests, number
> of allocated pages/blocks and avoid possible memory fragmentation (however, I believe
> the latter is already handled at the mm layer).

Indeed, lets keep it as-is.
