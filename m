From: tj@kernel.org (Tejun Heo)
Date: Thu, 5 Dec 2013 13:51:16 -0500
Subject: [PATCH v2 08/23] mm/memblock: Add memblock memory allocation apis
In-Reply-To: <902E09E6452B0E43903E4F2D568737AB097B26B2@DNCE04.ent.ti.com>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-9-git-send-email-santosh.shilimkar@ti.com>
 <20131203232445.GX8277@htj.dyndns.org> <52A0AB34.2030703@ti.com>
 <20131205165325.GA24062@mtj.dyndns.org>
 <902E09E6452B0E43903E4F2D568737AB097B26B2@DNCE04.ent.ti.com>
Message-ID: <20131205185116.GA27274@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Thu, Dec 05, 2013 at 06:48:21PM +0000, Strashko, Grygorii wrote:
> +/* Fall back to all the existing bootmem APIs */
> +#define memblock_virt_alloc(x) \
> +       __alloc_bootmem(x, SMP_CACHE_BYTES, BOOTMEM_LOW_LIMIT)
> 
> which will be transformed to 
> +/* Fall back to all the existing bootmem APIs */
> +#define memblock_virt_alloc(x, align) \
> +       __alloc_bootmem(x, align, BOOTMEM_LOW_LIMIT)
> 
> and used as
> 
> memblock_virt_alloc(size, 0);
> 
> so, by default bootmem code will use 0 as default alignment and not SMP_CACHE_BYTES
> and that is wrong.

Just translate it to SMP_CACHE_BYTES?  Am I missing something here?
You're defining a new API which wraps around two interfaces.  Wrap
them so that they show the same desired behavior?

-- 
tejun
