From: vkoul@kernel.org (Vinod)
Date: Tue, 31 Jul 2018 09:59:03 +0530
Subject: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
In-Reply-To: <e5112c28-a010-827b-c1fd-ecf00036412a@ti.com>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
 <20180710055230.GB3219@vkoul-mobl>
 <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
 <20180719092224.GK3219@vkoul-mobl>
 <eb5acd10-e255-774b-e8bc-f88eb2af172a@ti.com>
 <20180724111425.GK3219@vkoul-mobl>
 <e5112c28-a010-827b-c1fd-ecf00036412a@ti.com>
Message-ID: <20180731042903.GC16775@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-07-18, 12:46, Peter Ujfalusi wrote:
> Vinod,
> 
> On 2018-07-24 14:14, Vinod wrote:
> >>>> Clients must not mix the two way of handling the metadata.
> >>>> The set_len() is intended to tell the DMA driver the client provided
> >>>> metadata size (in MEM_TO_DEV case mostly).
> >>>>
> >>>> MEM_TO_DEV flow on client side:
> >>>> get_ptr()
> >>>> fill in the metadata to the pointer (not exceeding max_len)
> >>>> set_len() to tell the DMA driver the amount of valid bytes written
> >>>>
> >>>> DEV_TO_MEM flow on client side:
> >>>> In the completion callback, get_ptr()
> >>>> the metadata is payload_len bytes and can be accessed in the return pointer.
> >>>
> >>> I would think to unify this..
> >>
> >> I have tried it, but the attach mode and the pointer mode is hard to
> >> handle with a generic API.
> >> I will try to find a way to unify things in a sane way.
> > 
> > Hmmm, looking from the description they will be for different methods,
> > so lets make them orthogonal and not allow driver to register both.
> 
> I would allow DMA drivers to register both, but somehow enforce that
> clients are not mixing the two distinct way of dealing with the metadata.
> 
> The reason for that is for example the attach mode is the simplest (I
> implemented it first and I have a client using it), but if the pointer
> mode is found to be more efficient and feasible for the DMA then the DMA
> driver can implement that mode and the client can move as well w/o
> breaking anything.

Sounds reasonable...

-- 
~Vinod
