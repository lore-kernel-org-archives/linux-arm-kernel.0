From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Wed, 21 Sep 2011 09:30:51 -0700
Subject: [PATCH 1/3] fixup! mm: alloc_contig_freed_pages() added
In-Reply-To: <f57b57f83bc5980e3db7d9d42f91c7e1765b4766.1316622205.git.mina86@mina86.com>
References: <1316619959.16137.308.camel@nimitz>
	<f57b57f83bc5980e3db7d9d42f91c7e1765b4766.1316622205.git.mina86@mina86.com>
Message-ID: <1316622651.16137.311.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-09-21 at 18:26 +0200, Michal Nazarewicz wrote:
> -               page += 1 << order;
> +
> +               if (zone_pfn_same_memmap(pfn - count, pfn))
> +                       page += count;
> +               else
> +                       page = pfn_to_page(pfn);
>         }

That all looks sane to me and should fix the bug I brought up.

-- Dave
