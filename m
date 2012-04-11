From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Apr 2012 08:48:24 +0200
Subject: [PATCHv24 00/16] Contiguous Memory Allocator
In-Reply-To: <CA+K6fF5TbhYX_XYXL33h5s8cnSogSna4Cq2-vM4MfX4igSyozg@mail.gmail.com>
References: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
 <alpine.DEB.2.00.1204101528390.9354@kernel.research.nokia.com>
 <CA+K6fF5TbhYX_XYXL33h5s8cnSogSna4Cq2-vM4MfX4igSyozg@mail.gmail.com>
Message-ID: <00c201cd17af$17a3aa50$46eafef0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday, April 10, 2012 7:20 PM Sandeep Patil wrote:

> >> This is (yet another) update of CMA patches.
> >
> >
> > How well CMA is supposed to work if you have mlocked processes? I've
> > been testing these patches, and noticed that by creating a small mlocked
> > process you start to get plenty of test_pages_isolated() failure warnings,
> > and bigger allocations will always fail.
> 
> CMIIW, I think mlocked pages are never migrated. The reason is because
> __isolate_lru_pages() does not isolate Unevictable pages right now.
> 
> Minchan added support to allow this but the patch was dropped.
> 
> See the discussion at : https://lkml.org/lkml/2011/8/29/295

Right, we are aware of this limitation. We are working on solving it but we didn't 
consider it a blocker for the core CMA patches. Such issues can be easily fixed with 
the incremental patches.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
