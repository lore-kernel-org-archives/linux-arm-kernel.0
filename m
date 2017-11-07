From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Tue, 7 Nov 2017 19:24:38 +0300
Subject: [PATCH v2 2/2] arm64/mm/kasan: don't use vmemmap_populate() to
 initialize shadow
In-Reply-To: <20171106183516.6644-3-pasha.tatashin@oracle.com>
References: <20171106183516.6644-1-pasha.tatashin@oracle.com>
 <20171106183516.6644-3-pasha.tatashin@oracle.com>
Message-ID: <a1f63638-7edd-a498-d89f-67dea59a247a@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2017 09:35 PM, Pavel Tatashin wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> The kasan shadow is currently mapped using vmemmap_populate() since that
> provides a semi-convenient way to map pages into init_top_pgt. However,
> since that no longer zeroes the mapped pages, it is not suitable for kasan,
> which requires zeroed shadow memory.
> 
> Add kasan_populate_shadow() interface and use it instead of
> vmemmap_populate(). Besides, this allows us to take advantage of gigantic
> pages and use them to populate the shadow, which should save us some memory
> wasted on page tables and reduce TLB pressure.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com> 
