From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 6 Mar 2017 11:32:04 +0100
Subject: [RFC PATCH 10/12] staging: android: ion: Use CMA APIs directly
In-Reply-To: <0541f57b-4060-ea10-7173-26ae77777518@redhat.com>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <1488491084-17252-11-git-send-email-labbott@redhat.com>
 <2140021.hmlAgxcLbU@avalon>
 <0541f57b-4060-ea10-7173-26ae77777518@redhat.com>
Message-ID: <20170306103204.d3yf6woxpsqvdakp@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 10:50:20AM -0800, Laura Abbott wrote:
> On 03/03/2017 08:41 AM, Laurent Pinchart wrote:
> > Hi Laura,
> > 
> > Thank you for the patch.
> > 
> > On Thursday 02 Mar 2017 13:44:42 Laura Abbott wrote:
> >> When CMA was first introduced, its primary use was for DMA allocation
> >> and the only way to get CMA memory was to call dma_alloc_coherent. This
> >> put Ion in an awkward position since there was no device structure
> >> readily available and setting one up messed up the coherency model.
> >> These days, CMA can be allocated directly from the APIs. Switch to using
> >> this model to avoid needing a dummy device. This also avoids awkward
> >> caching questions.
> > 
> > If the DMA mapping API isn't suitable for today's requirements anymore, I 
> > believe that's what needs to be fixed, instead of working around the problem 
> > by introducing another use-case-specific API.
> > 
> 
> I don't think this is a usecase specific API. CMA has been decoupled from
> DMA already because it's used in other places. The trying to go through
> DMA was just another layer of abstraction, especially since there isn't
> a device available for allocation.

Also, we've had separation of allocation and dma-mapping since forever,
that's how it works almost everywhere. Not exactly sure why/how arm-soc
ecosystem ended up focused so much on dma_alloc_coherent.

I think separating allocation from dma mapping/coherency is perfectly
fine, and the way to go.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
