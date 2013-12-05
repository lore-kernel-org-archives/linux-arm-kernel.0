From: tj@kernel.org (Tejun Heo)
Date: Thu, 5 Dec 2013 11:53:25 -0500
Subject: [PATCH v2 08/23] mm/memblock: Add memblock memory allocation apis
In-Reply-To: <52A0AB34.2030703@ti.com>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-9-git-send-email-santosh.shilimkar@ti.com>
 <20131203232445.GX8277@htj.dyndns.org> <52A0AB34.2030703@ti.com>
Message-ID: <20131205165325.GA24062@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 05, 2013 at 06:35:00PM +0200, Grygorii Strashko wrote:
> >> +#define memblock_virt_alloc_align(x, align) \
> >> +	memblock_virt_alloc_try_nid(x, align, BOOTMEM_LOW_LIMIT, \
> >> +				     BOOTMEM_ALLOC_ACCESSIBLE, MAX_NUMNODES)
> > 
> > Also, do we really need this align variant separate when the caller
> > can simply specify 0 for the default?
> 
> Unfortunately Yes. 
> We need it to keep compatibility with bootmem/nobootmem
> which don't handle 0 as default align value.

Hmm... why wouldn't just interpreting 0 to SMP_CACHE_BYTES in the
memblock_virt*() function work?

Thanks.

-- 
tejun
