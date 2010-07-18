From: minchan.kim@gmail.com (Minchan Kim)
Date: Sun, 18 Jul 2010 23:13:10 +0900
Subject: [PATCH] Tight check of pfn_valid on sparsemem - v2
In-Reply-To: <AANLkTilQf-43GMAIDa-MKmcB2afdVgkERMg0b5mhIbhE@mail.gmail.com>
References: <1279448311-29788-1-git-send-email-minchan.kim@gmail.com>
	<AANLkTilQf-43GMAIDa-MKmcB2afdVgkERMg0b5mhIbhE@mail.gmail.com>
Message-ID: <20100718141240.GA30402@barrios-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyoungmin, 

On Sun, Jul 18, 2010 at 08:53:25PM +0900, Kyungmin Park wrote:
> Hi Minchan,
> 
> Please see the OneDRAM spec. it's OneDRAM memory usage.
> Actually memory size is 80MiB + 16MiB at AP side and it's used 80MiB
> for dedicated AP.
> The shared 16MiB used between AP and CP. So we also use the 16MiB.

It's not only s5pv210 but general problem of memmap hole 
on ARM's sparsemem. 

It doesn't matter with 16M or 80M. 
The thing is that section size is greater than physical memory's groups.

Current sparsemen aren't designed to have memmap hole but ARM makes holes
to save memory space. So we should solve it by not SECTION_SIZE but more 
fundamental solution.

I think this patch suggests it.
-- 
Kind regards,
Minchan Kim
