From: rientjes@google.com (David Rientjes)
Date: Tue, 3 Dec 2013 15:41:38 -0800 (PST)
Subject: [PATCH] mm, show_mem: Remove SHOW_MEM_FILTER_PAGE_COUNT
In-Reply-To: <20131203145721.GQ11295@suse.de>
References: <20131016104228.GM11028@suse.de>
 <alpine.DEB.2.02.1310161809470.12062@chino.kir.corp.google.com>
 <20131203145721.GQ11295@suse.de>
Message-ID: <alpine.DEB.2.02.1312031541240.5946@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Dec 2013, Mel Gorman wrote:

> Commit 4b59e6c4 (mm, show_mem: suppress page counts in non-blockable
> contexts) introduced SHOW_MEM_FILTER_PAGE_COUNT to suppress PFN walks
> on large memory machines. Commit c78e9363 (mm: do not walk all of system
> memory during show_mem) avoided a PFN walk in the generic show_mem helper
> which removes the requirement for SHOW_MEM_FILTER_PAGE_COUNT in that case.
> 
> This patch removes PFN walkers from the arch-specific implementations that
> report on a per-node or per-zone granularity. ARM and unicore32 still do
> a PFN walk as they report memory usage on each bank which is a much finer
> granularity where the debugging information may still be of use. As the
> remaining arches doing PFN walks have relatively small amounts of memory,
> this patch simply removes SHOW_MEM_FILTER_PAGE_COUNT.
> 
> Signed-off-by: Mel Gorman <mgorman@suse.de>

Acked-by: David Rientjes <rientjes@google.com>

Thanks!
