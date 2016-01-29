From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 29 Jan 2016 13:42:40 +0200
Subject: [PATCH] fbdev: da8xx-fb: remove incorrect type cast
In-Reply-To: <1453734351-1958373-1-git-send-email-arnd@arndb.de>
References: <1453734351-1958373-1-git-send-email-arnd@arndb.de>
Message-ID: <56AB5030.5040203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/01/16 17:05, Arnd Bergmann wrote:
> The probe function correct passes a dma_addr_t pointer into
> dma_alloc_coherent(), but has a cast to resource_size_t, which
> might be different from dma_addr_t:
> 
> drivers/video/fbdev/da8xx-fb.c: In function 'fb_probe':
> drivers/video/fbdev/da8xx-fb.c:1431:10: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
> 
> This removes the cast, which avoids the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/da8xx-fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, queued for 4.5 fixes.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/a67d14d2/attachment-0001.sig>
