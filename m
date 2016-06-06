From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Jun 2016 15:06:18 +0200
Subject: [PATCH] drm: sun4i: fix LPAE warnings
In-Reply-To: <1464973051-20432-1-git-send-email-andre.przywara@arm.com>
References: <1464973051-20432-1-git-send-email-andre.przywara@arm.com>
Message-ID: <4683820.tGQACgnbJT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 3, 2016 5:57:31 PM CEST Andre Przywara wrote:
> When the sun4i DRM driver is compiled with LPAE enabled, dma_addr_t turns
> into a 64-bit type, which causes warnings with some debug printks:
> =================
> In file included from
> drivers/gpu/drm/sun4i/sun4i_backend.c:13::
> drivers/gpu/drm/sun4i/sun4i_backend.c: In function 'sun4i_backend_update_layer_buffer':
> drivers/gpu/drm/sun4i/sun4i_backend.c:193:19: warning:
> format '%x' expects argument of type 'unsigned int', but argument 3 has
> type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
>   DRM_DEBUG_DRIVER("Using GEM @ 0x%x\n", gem->paddr);
>                    ^
> include/drm/drmP.h:207:34: note: in definition of macro
> 'DRM_DEBUG_DRIVER'
>     drm_ut_debug_printk(__func__, fmt, ##args); \
> .....
> 
> Use the proper printk format specifier [1] for dma_addr_t which takes
> care of those differences.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 

I submitted the same patch a month ago, and it's already in linux-next,
I assume it will show up in mainline soon.

	arnd
