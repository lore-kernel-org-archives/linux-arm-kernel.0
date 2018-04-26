From: joro@8bytes.org (joro at 8bytes.org)
Date: Thu, 26 Apr 2018 22:07:37 +0200
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <1524764948.2693.478.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
 <1524764948.2693.478.camel@hpe.com>
Message-ID: <20180426200737.GS15462@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 05:49:58PM +0000, Kani, Toshi wrote:
> On Thu, 2018-04-26 at 19:23 +0200, joro at 8bytes.org wrote:
> > So the PMD entry you clear can still be in a page-walk cache and this
> > needs to be flushed too before you can free the PTE page. Otherwise
> > page-walks might still go to the page you just freed. That is especially
> > bad when the page is already reallocated and filled with other data.
> 
> I do not understand why we need to flush processor caches here. x86
> processor caches are coherent with MESI.  So, clearing an PMD entry
> modifies a cache entry on the processor associated with the address,
> which in turn invalidates all stale cache entries on other processors.

A page walk cache is not about the processors data cache, its a cache
similar to the TLB to speed up page-walks by caching intermediate
results of previous page walks.


Thanks,

	Joerg
