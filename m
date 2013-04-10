From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 10 Apr 2013 12:48:05 -0400
Subject: [PATCH RESEND v2 1/1] ARM Feroceon: fix kexec by setting
 outer_cache.inv_all
In-Reply-To: <51631BAF.40408@grapecom.com>
References: <51631B12.2010908@grapecom.com>
 <51631BAF.40408@grapecom.com>
Message-ID: <20130410164805.GA28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 10:34:07PM +0300, Elijah Ragozin wrote:
> On Feroceon the L2 cache becomes non-coherent with the CPU
> when the L1 caches are disabled. Thus the L2 needs to be invalidated
> after both L1 caches are disabled.
> 
> On kexec before the starting the code for relocation the kernel,
> the L1 caches are disabled in cpu_froc_fin (cpu_v7_proc_fin for Feroceon),
> but after L2 cache is never invalidated, because inv_all is not set
> in cache-feroceon-l2.c.
> So kernel relocation and decompression may has (and usually has) errors.
> Setting the function enables L2 invalidation and fixes the issue.
> 
> Signed-off-by: Illia Ragozin <illia.ragozin@grapecom.com>
> ---
>  arch/arm/mm/cache-feroceon-l2.c | 1 +
>  1 file changed, 1 insertion(+)

fwiw,

Acked-by: Jason Cooper <jason@lakedaemon.net>

Please put this in Russell King's patch tracker so he can pull it in.

thx,

Jason.
