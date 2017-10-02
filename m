From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Oct 2017 15:03:35 +0100
Subject: [PATCH] [DEV] dma mapping : export caller to vmallocinfo
In-Reply-To: <20171002130155.19325-1-matthieu.castet@parrot.com>
References: <20171002130155.19325-1-matthieu.castet@parrot.com>
Message-ID: <20171002140335.535sgt4x7phlyowo@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 03:01:55PM +0200, Matthieu CASTET wrote:
> For example on arm64 board, this add info to "user" entries in vmallocinfo
> 
> Before :
> [...]
> 0xffffff8008997000 0xffffff80089d8000 266240 user
> [...]
> 
> Afer :
> [...]
> 0xffffff8008997000 0xffffff80089d8000 266240 atomic_pool_init+0x0/0x1d8 user
> [...]
> 
> This help to debug mapping issues, and is consistent with others entries
> (ioremap, vmalloc, ...) that already provide caller.
> 
> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It looks fine to me. Will (cc'ed) should pick it up for 4.15.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
